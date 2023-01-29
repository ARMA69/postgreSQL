const { User, client, Order, Phone } = require("./models");
const { getUsers } = require("./api/fetch");
const { generatePhones } = require("./utils");

async function start() {
  await client.connect();

  // const userArray = await getUsers();
  // const res = await User.bulkCreate(userArray);

  const { rows: users } = await User.findAll();
  const phones = await Phone.bulkCreate(generatePhones(100));
  const orders = await Order.bulkCreate(users, phones);

  await client.end();
}

start();
