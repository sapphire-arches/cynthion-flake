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
    version = "1.1.0";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "apollo";
      rev = "v" + version;
      hash = "sha256-CVMSTjrfrtvfVFbMVvx2FYhkkonvEpiSZ+buqOzHyXk";
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

    pythonPath = with python3Packages; [
      deprecation
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
