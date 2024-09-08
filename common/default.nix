{ config, ... }: {
  config.mods = {
    sops.secrets = {
      hub = { };
      lab = { };
      ${config.conf.username} = { };
      nextcloud = { };
      access = { };
    };
  };
}
