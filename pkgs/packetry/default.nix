{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  glib,
  graphene,
  gdk-pixbuf,
  gtk4,
  wrapGAppsHook,
}:
rustPlatform.buildRustPackage rec {
  version = "0.2.2";
  pname = "packetry";

  src = fetchFromGitHub rec {
    owner = "greatscottgadgets";
    repo = "packetry";
    rev = "v" + version;
    hash = "sha256-FlimHJS3hwB2Tkulb8uToKFe165uv/gFxJ4uezVNka4=";
  };

  cargoSha256 = "sha256-n1hPoSUEFUGpEUOiuirSbeAnU+qiENDg4XyN5Jkjo/Y=";

  nativeBuildInputs = [
    wrapGAppsHook
    pkg-config
  ];

  doCheck = false;

  buildInputs = [
    glib
    graphene
    gdk-pixbuf
    gtk4
  ];

  meta = with lib; {
    description = "A fast, intuitive USB 2.0 protocol analysis application for use with Cynthion.";
    homepage = "https://github.com/greatscottgadgets/packetry/";
    license = licenses.bsd3;
    platforms = platforms.all;
  };
}
