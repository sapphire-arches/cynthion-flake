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
    version = "0.5.2";

    pyproject = true;

    src = fetchFromGitHub rec {
      owner = "greatscottgadgets";
      repo = "pyfwup";
      rev = version;
      hash = "sha256-Kyc3f8beTg0W1+U7SvZuNPN1pdsco9rBUfoEtR7AI44=";
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
