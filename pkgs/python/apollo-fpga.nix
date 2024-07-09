{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  python3Packages,
  pkgs,
  amaranth-041,
  luna-usb,
  pyusb,
  pyvcd,
  prompt-toolkit,
  pyxdg,
  setuptools,
  setuptools-git-versioning,
}: let
in
  buildPythonPackage rec {
    pname = "apollo-fpga";
    version = "1.0.7";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "apollo";
      rev = "v1.0.7";
      hash = "sha256-sREQpe28MBW+RGFag4OLZsjjvUan6ctZ83aFOMuc3EU=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [
      setuptools
      setuptools-git-versioning
    ];

    propagatedBuildInputs = [
      amaranth-041
      luna-usb
      pyusb
      pyvcd
      prompt-toolkit
      pyxdg
    ];

    postPatch = ''
      substituteInPlace pyproject.toml \
        --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
    '';

    meta = {
      description = "Amaranth HDL framework for monitoring, hacking, and developing USB devices";
      homepage = "https://github.com/greatscottgadgets/luna";
      license = lib.licenses.bsd3;
    };
  }
