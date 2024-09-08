{ config, ... }: {
  imports = [ ../../common ];
  conf = {
    defaultMonitor = "eDP-1";
    defaultMonitorMode = "2944x1840@90";
    defaultMonitorScale = "2";
    boot_params = [ "rtc_cmos.use_acpi_alarm=1" ];
    ironbar.modules = [{
      type = "upower";
      class = "memory-usage";
    }];
  };
  mods = {
    stylix.colorscheme = "catppuccin-mocha";
    hyprland = { extra_autostart = [ "hyprdock --server" ]; };
    gpu.amdgpu.enable = true;
    kde_connect.enable = true;
    bluetooth.enable = true;
    acpid.enable = true;
    nextcloud = {
      synclist = [
        {
          name = "document_sync";
          remote = "/Documents";
          local = "/home/${config.conf.username}/Documents";
        }
        {
          name = "picture_sync";
          remote = "/Pictures";
          local = "/home/${config.conf.username}/Pictures";
        }
        {
          name = "pw_sync";
          remote = "PWs";
          local = "/home/${config.conf.username}/Music";
        }
      ];
    };
  };
}
