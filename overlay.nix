final: prev: {
  packetry = final.callPackage ./pkgs/packetry {};
  python-cynthion = final.python3.override {
    packageOverrides = import ./pkgs/python;
  };
  apollo-cynthion = final.python-cynthion.pkgs.callPackage ./pkgs/cynthion/apollo-firmware.nix {board = "cynthion";};
  cynthion = final.callPackage ./pkgs/cynthion {};
  cynthion-unwrapped = final.python-cynthion.pkgs.callPackage ./pkgs/cynthion/cynthion.nix {};
  cynthion-gateware-single = final.callPackage ./pkgs/cynthion/single-gateware.nix {};
  cynthion-gateware = final.callPackage ./pkgs/cynthion/gateware.nix {};
  cynthion-moondancer = final.callPackage ./pkgs/cynthion/moondancer-bin.nix {};
  cynthion-udev = final.callPackage ./pkgs/cynthion/udev.nix {};
  apollo-fpga = final.python-cynthion.pkgs.apollo-fpga;
}
