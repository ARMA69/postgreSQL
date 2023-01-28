const { Client } = require("pg");

const configs = {
  host: "localhost",
  port: 5432,
  user: "postgres",
  password: "qweasdzxc",
  database: "students",
};

const client = new Client(configs);

async function start() {
  await client.connect();

  const res = await client.query(
    `INSERT INTO users (fist_name, last_name, email, is_subscribe) VALUES
    ('Feed', 'Xan', 'qeeqweqrk@mail.com', true)`
  );

  console.log(res);

  await client.end();
}

start();
