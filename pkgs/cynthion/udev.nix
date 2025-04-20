{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:

let
  src = import ./src.nix fetchFromGitHub;
in
  stdenvNoCC.mkDerivation {
    pname = "cynthion-udev";
    version = src.rev;
    dontBuild = true;
    dontFixup = true;

    src = import ./src.nix fetchFromGitHub;

    installPhase = ''
      mkdir -p $out/lib/udev/rules.d
      cp cynthion/python/assets/54-cynthion.rules $out/lib/udev/rules.d/54-cynthion.rules
    '';
  }
