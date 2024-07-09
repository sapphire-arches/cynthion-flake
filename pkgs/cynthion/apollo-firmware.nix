{
  fetchFromGitHub,
  stdenv,
  board,
  gcc-arm-embedded,
  ...
}: let
  uf2 = fetchFromGitHub {
    owner = "microsoft";
    repo = "uf2";
    rev = "c594542b2faa01cc33a2b97c9fbebc38549df80a";
    hash = "sha256-s+hVAXGqeEA2ZLYdTQ/JBci37FpmfxEKFkYwnXSWAzU=";
  };
  microchip-driver = fetchFromGitHub {
    owner = "hathach";
    repo = "microchip_driver";
    rev = "9e8b37e307d8404033bb881623a113931e1edf27";
    hash = "sha256-VfUeuiJXXJa59yLVMD5pi7j1YE7CyDrxvIuGqmiyoHY=";
  };
in
  stdenv.mkDerivation rec {
    pname = "apollo-${board}";
    version = "1.0.7";

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "apollo";
      rev = "v1.0.7";
      hash = "sha256-sREQpe28MBW+RGFag4OLZsjjvUan6ctZ83aFOMuc3EU=";
      fetchSubmodules = true;
    };

    APOLLO_BOARD = board;

    nativeBuildInputs = [gcc-arm-embedded];

    postPatch = ''
      ln -s ${microchip-driver} lib/tinyusb/hw/mcu/microchip
      ln -s ${uf2} lib/tinyusb/tools/uf2
    '';

    preConfigure = ''
      cd firmware
    '';

    installPhase = ''
      mkdir -p $out/share/assets
      cp _build/cynthion_d11/firmware.bin $out/share/assets/apollo.bin
    '';
  }
