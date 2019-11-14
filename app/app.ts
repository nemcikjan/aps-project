import express from "express";
import { connect } from "./db";
const multer = require("multer");
const upload = multer();
import * as _ from "lodash";
import * as moment from "moment";

function tryParseInt(toParse) {
  let retValue = toParse;
  if (toParse !== null) {
    if (toParse.length > 0) {
      if (!isNaN(toParse)) {
        retValue = parseFloat(toParse);
      }
    }
  }
  return retValue;
}

(async () => {
  const client = await connect();
  const app = express();
  app.post("/result", upload.any(), (req, res) => {
    const file = (req.files[0].buffer as Buffer).toString();
    const matched = file.match("docker");
    const isDocker = matched && matched.length;
    const dockerHost = isDocker && file.match(/(?<=Hostname:\s).+$/gm)[0];
    let result = JSON.parse(
      JSON.stringify(
        _.fromPairs(
          _.chunk(
            file
              .split(/:|\n/gm)
              .map(e => e.trim())
              .filter(e => !!e)
              .map((e, i) => (i % 2 === 0 ? _.camelCase(e) : e))
              .map(e => {
                const m = e.match(/^(?<=)\d+(\.*\d*)/gm);
                return (m && m.length && m[0]) || e;
              })
              .map(e => tryParseInt(e)),
            2
          )
        )
      )
    );

    result = dataMapper(result);
    const q = `INSERT INTO result (time,
		numOfCores,
		cpuName,
		memUsage,
		cpuUsage,
		arch,
		hostname,
		userName) VALUES (${result.time}, ${result.numOfCores}, '${result.cpuName}', ${
      result.memUsage
    }, ${result.cpuUsage}, '${result.arch}', '${
      isDocker ? dockerHost : result.hostname
    }', '${result.userName}');`;
    console.log(q);
    client
      .query(q)
      .then(() => {
        res.status(201).send("Successfully uploaded!\n");
      })
      .catch(e => {
        res.status(500).send(e);
      });
  });
  app.get("/result/:user/:timestamp/:host", (req, res) => {
    const { user, timestamp, host } = req.params;
    let q = "";
    if (user === "all") {
      q = `select * from result`;
    } else {
      if (host === "all") {
        q = `select * from result where username = '${user}'`;
      } else {
        q = `select * from result where username = '${user}' and hostname = '${host}'`;
      }
    }
    if (timestamp === "last") {
      q += " order by timestamp desc limit 1;";
    } else {
      q += " order by timestamp desc;";
    }
    console.log(q);
    client
      .query(q)
      .then(({ rows }) =>
        res
          .status(200)
          .send(
            rows.map(r =>
              _.mapValues(r, v => (typeof v === "string" ? v.trim() : v))
            )
          )
      )
      .catch(e => res.status(500).send(e));
  });
  app.listen(3000, () => {
    console.info("listening on port 3000");
  });
})();

const MB_TO_KB_DIVIDER = 1000;
const FORMAT = "h:mm:ss";

function convertToMBytes(memSize: number) {
  return memSize / MB_TO_KB_DIVIDER;
}

function countCpuUsage(overall: number, numOfCores: number) {
  return overall / numOfCores;
}

function convertToMins(timeinSecs: number) {
  return moment.utc(timeinSecs * 1000).format(FORMAT);
}

function dataMapper(result) {
  const replacer = (key: string) => {
    switch (key) {
      case "totalTime":
        return "time";
      case "memory":
        return "memUsage";
      case "architecture":
        return "arch";
      case "modelName":
        return "cpuName";
      case "executedWith":
        return "numOfCores";
      default:
        return key;
    }
  };
  const mappedResult = _.mapKeys(result, (v, k) => replacer(k));
  // mappedResult.time = convertToMins(mappedResult.time);
  mappedResult.cpuUsage = countCpuUsage(
    mappedResult.cpuUsage,
    mappedResult.numOfCores
  );
  // mappedResult.memUsage = convertToMBytes(mappedResult.memUsage);
  return mappedResult;
}
