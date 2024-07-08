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
  version = "0.1.0";
  pname = "packetry";

  src = fetchFromGitHub {
    owner = "greatscottgadgets";
    repo = "packetry";
    rev = "7af5d7fd5c3cefe0291ea8eadcec5200dc6362d0";
    hash = "sha256-jGCSI7aI5HenF5s2SKarABHQyCaRSag9jqnihT1WvGM=";
  };

  cargoSha256 = "sha256-h9fFP5VGjYKt42oN/VSghfKPco+1DEh+W3fktYO8RVY=";

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
