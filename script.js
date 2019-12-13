const fs = require('fs');
function regres(cores) {
	return -782.5 * cores + 22451.16667;
}

const LENGTH = 27;
const array = new Array(27)
	.fill(0)
	.map((e, i) => ({
		numofcores: LENGTH - i,
		time: regres(LENGTH - i),
		group: 1
	}))
	.slice(0, LENGTH - 1);

fs.writeFileSync('array.json', JSON.stringify(array));
