{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/release-24.05";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      overlays = [
        (import ./overlay.nix)
      ];
      pkgs = (import nixpkgs) {
        inherit system overlays;
      };
      inherit (pkgs) lib;
    in rec {
      devShells.default = pkgs.mkShell {

      };
      packages = {
        inherit (pkgs) packetry cynthion cynthion-udev;
      };
    })
    // {
      overlays.default = import ./overlay.nix;
    };
}
