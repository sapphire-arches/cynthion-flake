{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  setuptools-git-versioning,
  pyvcd,
  pyusb,
  libusb1,
  pyserial,
  amaranth-041,
  usb-protocol,
}: let
in
  buildPythonPackage rec {
    pname = "luna-usb";
    version = "0.1.2";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "luna";
      rev = version;
      hash = "sha256-T9V0rI6vcEpM3kN/duRni6v2plCU4B379Zx07dBGKjk=";
    };

    nativeBuildInputs = [
      setuptools
      setuptools-git-versioning
    ];

    propagatedBuildInputs = [
      pyusb
      libusb1
      pyserial
      amaranth-041
      pyvcd
      usb-protocol
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
