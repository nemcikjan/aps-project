create table result (
    id serial primary key not null, 
    time float, 
    numOfCores int, 
    cpuName char(50), 
    memUsage int, 
    cpuUsage int, 
    arch char(10),
    hostname char(50),
    username char (50),
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW()
);