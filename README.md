# Cynthion-flake

A nix flake packaging [cynthion](https://github.com/greatscottgadgets/cynthion/) and related tools.

## Usage

- Add this flake to your flake inputs:
  ```
  cynthion.url = "github:icewind1991/cynthion-flake";  
  cynthion.inputs.nixpkgs.follows = "nixpkgs";
  ```

- Apply the overlay:
  ```
  nixpkgs.overlays = [inputs.cynthion.overlays.default];
  ```

- Install the udev rule
  ```nix
  services.udev.packages = with pkgs; [cynthion-udev];
  ```

- Install the packages
  ```nix
  environment.systemPackages = with pkgsl [cynthion packetry];
  ```

## Provided packages

- [cynthion](https://github.com/greatscottgadgets/cynthion/)
- cynthion-udev
- [packetry](https://github.com/greatscottgadgets/packetry)
- [apollo-fpga](https://github.com/greatscottgadgets/apollo)