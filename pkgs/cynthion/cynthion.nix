{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,
  setuptools,
  setuptools-git-versioning,
  libusb1,
  pyusb,
  tomli,
  future,
  prompt-toolkit,
  tabulate,
  tqdm,
  pyserial,
  amaranth-041,
  luna-usb,
  luna-soc,
  apollo-fpga,
  pyfwup,
  pygreat-2024,
  yosys,
  nextpnr,
  trellis,
}: let
in
  buildPythonPackage rec {
    pname = "cynthion-unwrapped";
    version = src.rev;

    outputs = ["out" "udev"];
    pyproject = true;

    src = import ./src.nix fetchFromGitHub;

    nativeBuildInputs = [
      setuptools
      setuptools-git-versioning
    ];

    propagatedBuildInputs = [
      libusb1
      pyusb
      tomli
      future
      prompt-toolkit
      tabulate
      tqdm
      pyserial
      amaranth-041
      luna-usb
      luna-soc
      apollo-fpga
      pyfwup
      pygreat-2024
      trellis
    ];

    postPatch = ''
      substituteInPlace cynthion/python/src/commands/util.py \
        --replace-fail 'os.path.join(package_path, "assets")' "\"$out/share/assets\""
      substituteInPlace cynthion/python/pyproject.toml \
        --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
    '';

    preBuild = ''
      cd cynthion/python
    '';

    postInstall = ''
      mkdir -p $udev/lib/udev/rules.d
      cp assets/54-cynthion.rules $udev/lib/udev/rules.d/54-cynthion.rules
    '';

    meta = {
      description = "Cynthion is an all-in-one tool for building, testing, monitoring, and experimenting with USB device";
      homepage = "https://github.com/greatscottgadgets/cynthion";
      license = lib.licenses.bsd3;
    };
  }
