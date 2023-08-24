{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        with pkgs; {
          devShells = {
            default = mkShell {
              packages = [ python3 ];
            };
          };

          packages = rec {
            wsl-sudo = callPackage ./. {
              inherit (pkgs)
                lib
                stdenv
                fetchFromGitHub
                python3;
            };
            default = wsl-sudo;
          };

          apps = rec {
            wsl-sudo = flake-utils.lib.mkApp {
              drv = self.packages.${system}.tunnels;
              exePath = "/bin/wsl-sudo";
            };
            default = wsl-sudo;
          };
        }
    );
}
