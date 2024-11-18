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
  version = "0.4.0";
  pname = "packetry";

  src = fetchFromGitHub rec {
    owner = "greatscottgadgets";
    repo = "packetry";
    rev = "v" + version;
    hash = "sha256-eDVom0kAL1QwO8BtrJS76VTvxtKs7CP6Ob5BWlE6wOM=";
  };

  cargoSha256 = "sha256-xz9PdVVB1u6s/anPBRonWS1kMN+4kfkK/gaOlF9Z3yk=";

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
