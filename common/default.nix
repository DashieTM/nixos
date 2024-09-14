{ config, ... }:
{
  config.mods = {
    sops = {
      sopsPath = "/home/${config.conf.username}/pws/secrets.yaml";
      validateSopsFile = false;
      secrets = {
        hub = { };
        lab = { };
        ${config.conf.username} = { };
        nextcloud = { };
        access = { };
      };
    };
  };
}
