const { Client } = require("pg");
const { mapUsers } = require("./utils");

const configs = {
  host: "localhost",
  port: 5432,
  user: "postgres",
  password: "qweasdzxc",
  database: "students",
};

const client = new Client(configs);

const userArray = [
  {
    firstName: "Test1",
    lastName: "Doe",
    email: "doe1@mail.com",
    isSubscribe: true,
  },
  {
    firstName: "Test2",
    lastName: "Doe",
    email: "doe2@mail.com",
    isSubscribe: true,
  },
  {
    firstName: "Test3",
    lastName: "Doe",
    email: "doe3@mail.com",
    isSubscribe: true,
  },
];

async function start() {
  await client.connect();

  const res = await client.query(
    `INSERT INTO users (fist_name, last_name, email, is_subscribe) VALUES
    ${mapUsers(userArray)}`
  );

  console.log(res);

  await client.end();
}

start();
