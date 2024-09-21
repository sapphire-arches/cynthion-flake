{
  stdenvNoCC,
  cynthion-unwrapped,
  zsh,
  yosys,
  nextpnr,
  trellis,
  bitstream ? null,
  platform ? null,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "cynthion-gateware-${bitstream}";
  version = "${cynthion-unwrapped.version}-${platform}";

  inherit (cynthion-unwrapped) src;
  dontFixup = true;

  nativeBuildInputs = [
    cynthion-unwrapped
    yosys
    nextpnr
    trellis
    zsh
  ];

  LUNA_PLATFORM = "cynthion.gateware.platform:${platform}";

  buildPhase = ''
    runHook preBuild

    mkdir -p assets/${platform}
    python -m cynthion.gateware.${bitstream}.top --dry-run --output assets/${platform}/${bitstream}.bit

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r assets $out/share
  '';
}
