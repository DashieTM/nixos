{ config, pkgs, ... }:
let
  username = config.conf.username;
in
{
  imports = [ ../../common ];

  # config variables
  conf = {
    defaultMonitor = "DP-1";
    defaultMonitorMode = "3440x1440@180";
    defaultMonitorScale = "1";
    streamdeck.enable = false;
  };
  mods = {

    basePackages.additionalPackages = with pkgs; [ streamcontroller ];
    # f to pay respect
    teams.enable = true;
    coding = {
      jetbrains = true;
      vscodium = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          ionide.ionide-fsharp
        ];
      };
    };
    gaming = {
      enable = true;
    };
    stylix.colorscheme = "catppuccin-mocha";
    hyprland = {
      noAtomic = true;
      monitor = [
        # default
        "DP-2,2560x1440@165,0x0,1"
        "DP-1,3440x1440@180,2560x0,1,vrr,0"
        "DP-3,1920x1080@144,6000x0,1"
        "DP-3,transform,1"

        # all others
        ",highrr,auto,1"
      ];

      workspace = [
        # workspaces
        # monitor middle
        "2,monitor:DP-1, default:true"
        "4,monitor:DP-1"
        "6,monitor:DP-1"
        "8,monitor:DP-1"
        "9,monitor:DP-1"
        "10,monitor:DP-1"

        # monitor left
        "1,monitor:DP-2, default:true"
        "5,monitor:DP-2"
        "7,monitor:DP-2"

        # monitor right
        "3,monitor:DP-3, default:true"
      ];
      hyprpaper.config = ''
        #load
        preload = /home/${username}/Pictures/backgrounds/shinobu_2k.jpg
        preload = /home/${username}/Pictures/backgrounds/shino_wide.png
        preload = /home/${username}/Pictures/backgrounds/shinobu_1080.jpg

        #set
        wallpaper = DP-2,/home/${username}/Pictures/backgrounds/shinobu_2k.jpg
        wallpaper = DP-1,/home/${username}/Pictures/backgrounds/shino_wide.png
        wallpaper = DP-3,/home/${username}/Pictures/backgrounds/shinobu_1080.jpg
        splash = true
      '';
      extraAutostart = [ "flatpak run streamcontroller -b" ];
    };
    drives.extraDrives = [
      {
        name = "drive2";
        drive = {
          device = "/dev/disk/by-label/DRIVE2";
          fsType = "ext4";
          options = [
            "noatime"
            "nodiratime"
            "discard"
          ];
        };
      }
    ];
    virtualbox.enable = true;
    kdeConnect.enable = true;
    xone.enable = true;
    gpu = {
      amdgpu.enable = true;
      vapi = {
        enable = true;
        rocm.enable = true;
      };
    };
    piper.enable = true;
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
          name = "phone_sync";
          remote = "Phone/Stuff";
          local = "/home/${config.conf.username}/Videos/Phone/Stuff";
        }
        {
          name = "pw_sync";
          remote = "PWs";
          local = "/home/${config.conf.username}/pws";
        }
      ];
    };
  };
}
