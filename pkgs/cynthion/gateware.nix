{
  symlinkJoin,
  cynthion-gateware-single,
  cynthion-unwrapped,
  lib,
  ...
}: let
  inherit (lib) crossLists;
  platformVersions = ["0D1" "0D2" "0D3" "0D4" "0D5" "0D6" "0D7" "1D0" "1D1" "1D2" "1D3" "1D4"];
  bitstreams = ["analyzer" "selftest" "facedancer"];
  gatewares = crossLists (platform: bitstream: (cynthion-gateware-single.override {
    inherit bitstream;
    platform = "CynthionPlatformRev${platform}";
  })) [platformVersions bitstreams];
in symlinkJoin {
  name = "cynthion-gateware-${cynthion-unwrapped.version}";
  paths = gatewares;
}
