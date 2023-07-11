{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, ... }:
    (inputs.flake-utils.lib.eachDefaultSystem (system:
      let

        inherit (pkgs) callPackage;

        pkgs = import inputs.nixpkgs {
          inherit system;
        };

        pkgs2 = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.rust-overlay.overlays.default ];
        };

      in
      rec {

        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs-18_x
            ];
          };
          withoverlay = pkgs2.mkShell {
            buildInputs = with pkgs2; [
              nodejs-18_x
            ];
          };
        };

      }));
}
