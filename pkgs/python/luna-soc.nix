{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  python3Packages,
  pkgs,
  luna-usb,
  setuptools,
  setuptools-git-versioning,
}: let
in
  buildPythonPackage rec {
    pname = "luna-soc";
    version = "0.2.0";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "luna-soc";
      rev = "0.2.0";
      hash = "sha256-P8P32hM1cVXENcDpCrmPe8BvkMCWdeEgHwbIU94uLe8=";
    };

    nativeBuildInputs = [
      setuptools
      setuptools-git-versioning
    ];

    propagatedBuildInputs = [
      luna-usb
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
