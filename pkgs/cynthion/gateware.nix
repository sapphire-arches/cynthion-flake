{
  stdenvNoCC,
  cynthion-unwrapped,
  zsh,
  yosys,
  nextpnr,
  trellis,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "cynthion-gateware";
  inherit (cynthion-unwrapped) version src;
  dontFixup = true;

  nativeBuildInputs = [
    cynthion-unwrapped
    yosys
    nextpnr
    trellis
    zsh
  ];

  preBuild = ''
    cd cynthion/python
  '';

  buildPhase = ''
    runHook preBuild

    make -j $NIX_BUILD_CORES SHELL=zsh bitstreams

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r assets $out/share
  '';
}
