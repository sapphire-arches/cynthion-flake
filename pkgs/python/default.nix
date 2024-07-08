py-final: _py-prev: {
  amaranth-041 = py-final.callPackage ./amaranth.nix {};
  luna-usb = py-final.callPackage ./luna-usb.nix {};
  luna-soc = py-final.callPackage ./luna-soc.nix {};
  apollo-fpga = py-final.callPackage ./apollo-fpga.nix {};
  pyfwup = py-final.callPackage ./pyfwup.nix {};
  pygreat-2024 = py-final.callPackage ./pygreat.nix {};
  usb-protocol = py-final.callPackage ./usb-protocol.nix {};
}
