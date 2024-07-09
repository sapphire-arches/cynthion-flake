{
  makeRustPlatform,
  rustc,
  cynthion-unwrapped,
  zsh,
  yosys,
  nextpnr,
  trellis,
  rust-bin,
  pkgsCross,
  ...
}: let
  # this doesn't work yet...
  toolchain = rust-bin.stable.${rustc.version}.default.override {
    extensions = ["rust-src"];
    targets = ["riscv32imac-unknown-none-elf"];
  };
  rustPlatform = pkgsCross.riscv32-embedded.pkgsBuildHost.makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "cynthion-moondancer";
    inherit (cynthion-unwrapped) version src;

    postPatch = ''
      cp ${./moondancer-cargo.lock} Cargo.lock

      substituteInPlace Cargo.toml \
              --replace-fail '[profile.release]' "[profile.release]
              panic=\"abort\""
    '';

    cargoLock = {
      lockFile = ./moondancer-cargo.lock;
    };

    sourceRoot = "source/firmware";

    cargoBuildFlags = ["-p moondancer" "--target riscv32imac-unknown-none-elf"];
  }
