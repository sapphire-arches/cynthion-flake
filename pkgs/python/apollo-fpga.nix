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
    version = "1.0.6";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "apollo";
      rev = "3a0e3a214eb1e6a9434b8e0bf15bcf7cf54f8242";
      hash = "sha256-t3XtBzinMysIBgONPIGLqFXpzBaCqMfY3sufjtRc7Io=";
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
