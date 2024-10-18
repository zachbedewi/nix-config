{configVars, ...}: {
  users.users."${configVars.username}" = {
    home = "/Users/${configVars.username}";
  };
}