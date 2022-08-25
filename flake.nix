{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        python = "python310";
        pkgs = import nixpkgs {
          inherit system;
        };
        harmony = (import ./harmony/harmony.nix { pkgs = pkgs; lib = pkgs.lib; });
        name = "harmony";
      in rec
      {
        packages.${name} = harmony;

        defaultPackage = packages.${name};

        apps.${name} = utils.lib.mkApp {
          inherit name;
          drv = packages.${name};
        };
        defaultApp = packages.${name};

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            pkgs.${python}
            graphviz
            harmony
          ];
        };
      });
}
