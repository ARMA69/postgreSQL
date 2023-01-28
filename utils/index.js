module.exports.mapUsers = (userArray) => {
  return userArray
    .map(
      (u) =>
        `('${u.firstName}', '${u.lastName}', '${u.email}', ${u.isSubscribe})`
    )
    .join(",");
};
