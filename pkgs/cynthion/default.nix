{
  cynthion-unwrapped,
  cynthion-gateware,
  cynthion-moondancer,
  apollo-cynthion,
  ...
}:
# because the gateware needs the python module, we do a weird 2-stage build
# where we build the cynthion package twice, once without gateware then again where we copy over the gateware
cynthion-unwrapped.overrideAttrs (oldAttrs: {
  pname = "cynthion";

  postInstall =
    oldAttrs.postInstall
    + ''
      mkdir -p $out/share/assets
      cp ${apollo-cynthion}/share/assets/apollo.bin $out/share/assets/apollo.bin
      cp ${cynthion-moondancer}/share/assets/moondancer.bin $out/share/assets/moondancer.bin
      cp -r ${cynthion-gateware}/share/assets/* $out/share/assets
    '';
})
