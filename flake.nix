{
  description = "Dashie dots";

  inputs = {
    #dashvim.url = "github:DashieTM/DashVim";
    dashvim.url = "git+file:///home/dashie/gits/dashvim";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    ironbar.url = "github:JakeStanger/ironbar?ref=3a1c60442382f970cdb7669814b6ef3594d9f048";
    anyrun.url = "github:Kirottu/anyrun";
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    stable.url = "github:NixOs/nixpkgs/nixos-24.05";

    oxicalc.url = "github:DashieTM/OxiCalc";
    oxishut.url = "github:DashieTM/OxiShut";
    oxinoti.url = "github:DashieTM/OxiNoti";
    oxidash.url = "github:DashieTM/OxiDash";
    oxipaste.url = "github:DashieTM/OxiPaste";
    hyprdock.url = "github:DashieTM/hyprdock";
    reset.url = "github:Xetibo/ReSet";
    reset-plugins.url = "github:Xetibo/ReSet-Plugins";
    zen-browser.url = "github:fufexan/zen-browser-flake";

    dashNix = {
      #url = "github:DashieTM/DashNix";
      url = "git+file:///home/dashie/gits/dashnix";
      inputs = {
        #zen-browser.follows = "zen-browser";
        nixpkgs.follows = "nixpkgs";
        stable.follows = "stable";
        dashvim.follows = "dashvim";
        hyprland.follows = "hyprland";
        ironbar.follows = "ironbar";
        anyrun.follows = "anyrun";
        oxicalc.follows = "oxicalc";
        oxipaste.follows = "oxipaste";
        oxinoti.follows = "oxinoti";
        oxidash.follows = "oxidash";
        hyprdock.follows = "hyprdock";
        reset.follows = "reset";
        reset-plugins.follows = "reset-plugins";
        zen-browser.follows = "zen-browser";
      };
    };
  };

  outputs =
    { ... }@inputs:
    {
      nixosConfigurations =
        inputs.dashNix.dashNixLib.build_systems {
          root = ./.;
          additionalInputs = inputs;
        }
        // {
          server = inputs.stable.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              pkgs = inputs.dashNix.stablePkgs;
            };
            modules = [
              inputs.dashNix.dashNixInputs.sops-nix.nixosModules.sops
              inputs.dashNix.dashNixInputs.dashvim.nixosModules.dashvim
              ./server/configuration.nix
            ];
          };
        };
    };

  nixConfig = {
    builders-use-substitutes = true;

    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
      "https://cache.garnix.io"
    ];

    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
