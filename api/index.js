const axios = requier("axios");

const http = axios.create({
  baseURL: "http://randomuser.me/api/",
});

module.exports.loadUsers = async () => {
  const res = await http.get("?results=100");
  console.log(res);
};
