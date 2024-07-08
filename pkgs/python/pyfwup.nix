{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  python3Packages,
  pyusb,
  tqdm,
  setuptools,
  setuptools-git-versioning,
}: let
in
  buildPythonPackage rec {
    pname = "pyfwup";
    version = "0.4.0";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "pyfwup";
      rev = "0.4.0";
      hash = "sha256-JSaAEGobdLqpSj9yvKrAsXfdkHpXSCcuGYRxz2QJqck=";
    };

    nativeBuildInputs = [
      setuptools
      setuptools-git-versioning
    ];

    propagatedBuildInputs = [
      pyusb
      tqdm
    ];

    postPatch = ''
      substituteInPlace pyproject.toml \
        --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
    '';

    meta = {
      description = "python library providing utilities, data structures, constants, parsers, and tools for working with USB data";
      homepage = "https://github.com/greatscottgadgets/python-usb-protocol";
      license = lib.licenses.bsd3;
    };
  }
