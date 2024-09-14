{ config, ... }:
{
  imports = [ ../../common ];
  # variables for system
  conf = {
    defaultMonitor = "DP-1";
    defaultMonitorMode = "1920x1080@144";
    defaultMonitorScale = "1";
    cpu = "intel";
  };
  mods = {
    gaming = {
      enable = true;
      gpu_device = 1;
    };
    hyprland = {
      no_atomic = true;
    };
    gpu.amdgpu.enable = true;
    kde_connect.enable = true;
    xone.enable = true;
    nextcloud = {
      synclist = [
        {
          name = "pw_sync";
          remote = "/PWs";
          local = "/home/${config.conf.username}/pws";
        }
      ];
    };
  };
}
