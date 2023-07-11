{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { self, ... }:
    (inputs.flake-utils.lib.eachDefaultSystem (system:
      let

        inherit (pkgs) callPackage;

        pkgs = import inputs.nixpkgs {
          inherit system;
        };

      in
      rec {

        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs-18_x
            ];
          };
        };

      }));
}
