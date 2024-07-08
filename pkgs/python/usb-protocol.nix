{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  construct,
  setuptools,
  setuptools-git-versioning,
}: let
in
  buildPythonPackage rec {
    pname = "usb-protocol";
    version = "0.9.1";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "python-usb-protocol";
      rev = "0.9.1";
      hash = "sha256-CYbXs/SRC1FAVEzfw0gwf6U0qQ9Q34nyuj5yfjHfDn8=";
    };

    nativeBuildInputs = [
      setuptools
      setuptools-git-versioning
    ];

    propagatedBuildInputs = [
      construct
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
