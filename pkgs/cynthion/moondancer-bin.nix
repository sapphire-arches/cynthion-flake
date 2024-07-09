{stdenvNoCC, ...}:
# use binary downloaded from pip untill cross-compiling can be figured out
stdenvNoCC.mkDerivation {
  pname = "cynthion-moondancer";
  version = "0.1.0";
  dontBuild = true;
  dontFixup = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/assets
    cp ${./moondancer.bin} $out/share/assets/moondancer.bin
  '';
}
