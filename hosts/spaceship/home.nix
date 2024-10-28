{ lib, pkgs, ... }:
let
  fsauto = pkgs.buildDotnetModule rec {
    pname = "fsautocomplete";
    version = "0.74.1";

    src = pkgs.fetchFromGitHub {
      owner = "fsharp";
      repo = "FsAutoComplete";
      rev = "v${version}";
      hash = "sha256-GVIBd0FX3rYn7KM0+QytNlMDobABBkRR6heFUCJq+Tg=";
    };

    nugetDeps = ./deps.nix;

    passthru = {
      fetch-deps = import ./restore.nix {
        dotnet = lib.getExe dotnet-sdk;
        nuget-to-nix = (pkgs.nuget-to-nix.override { inherit dotnet-sdk; });
        writeShellSript = pkgs.writeShellScript;
      };
    };

    postPatch = ''
      rm global.json

      substituteInPlace src/FsAutoComplete/FsAutoComplete.fsproj \
        --replace TargetFrameworks TargetFramework \
    '';

    dotnet-sdk =
      with pkgs.dotnetCorePackages;
      combinePackages [
        sdk_6_0_1xx
        sdk_7_0_1xx
        sdk_8_0_3xx
      ];
    dotnet-runtime = pkgs.dotnetCorePackages.sdk_8_0_3xx;

    projectFile = "src/FsAutoComplete/FsAutoComplete.fsproj";
    executables = [ "fsautocomplete" ];

    useDotnetFromEnv = true;

    meta = with lib; {
      description = "The FsAutoComplete project (FSAC) provides a backend service for rich editing or intellisense features for editors.";
      mainProgram = "fsautocomplete";
      homepage = "https://github.com/fsharp/FsAutoComplete";
      changelog = "https://github.com/fsharp/FsAutoComplete/releases/tag/v${version}";
      license = licenses.asl20;
      platforms = platforms.unix;
      maintainers = with maintainers; [
        gbtb
        mdarocha
      ];
    };
  };
in
{
  home.packages = [
    fsauto
    pkgs.helix
  ];
}
