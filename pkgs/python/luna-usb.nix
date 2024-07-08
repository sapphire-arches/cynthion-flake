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
    version = "0.1.1";

    pyproject = true;

    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "luna";
      rev = "0.1.1";
      hash = "sha256-81GJF3QLERCmvZXYlQvb1vzJFeGMSMNMwuGoaBJE8Zg=";
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
