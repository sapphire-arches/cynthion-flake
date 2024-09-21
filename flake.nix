{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/release-24.05";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }: let
      platformVersions = ["0D1" "0D2" "0D3" "0D4" "0D5" "0D6" "0D7" "1D0" "1D1" "1D2" "1D3" "1D4"];
      bitstreams = ["analyzer" "selftest" "facedancer"];
      gateware-matrix = nixpkgs.lib.mapCartesianProduct nixpkgs.lib.trivial.id {
        platform = platformVersions;
        bitstream = bitstreams;
      };
    in utils.lib.eachDefaultSystem (system: let
      overlays = [
        (import ./overlay.nix)
      ];
      pkgs = (import nixpkgs) {
        inherit system overlays;
      };
      inherit (pkgs) lib;

      cynthion-gateware-individual = lib.listToAttrs (map ({
          platform,
          bitstream,
        }: {
          name = "${bitstream}-${platform}";
          value = pkgs.cynthion-gateware-single.override {
            inherit bitstream;
            platform = "CynthionPlatformRev${platform}";
          };
        })
        gateware-matrix);
    in rec {
      devShells.default =
        pkgs.mkShell {
        };
      packages = {
        inherit (pkgs) packetry cynthion cynthion-udev apollo-cynthion cynthion-gateware apollo-fpga cynthion-unwrapped;
        inherit cynthion-gateware-individual;
      };
    })
    // {
      overlays.default = import ./overlay.nix;
      gateware-matrix = {
        include = gateware-matrix;
      };
    };
}
