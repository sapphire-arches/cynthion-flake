final: prev: {
  packetry = final.callPackage ./pkgs/packetry {};
  python-cynthion = final.python3.override {
    packageOverrides = import ./pkgs/python;
  };
  cynthion = final.python-cynthion.pkgs.callPackage ./pkgs/cynthion {};
  cynthion-udev = final.python-cynthion.pkgs.callPackage ./pkgs/cynthion/udev.nix {};
}
