{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "ignite";
  buildPhase = ''
      mkdir -p $out/bin $out/etc
  '';
  installPhase = 
    ''
      cp ignite $out/bin
      cp ignited $out/bin
    '';
  src = builtins.path { path = ./.; name = "ignite"; };
}