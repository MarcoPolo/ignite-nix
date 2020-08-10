{ pkgs ? import <nixpkgs> {} }:
let ignite = import ./ignite.nix {inherit pkgs;};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.hello
    ignite
    pkgs.git
    pkgs.binutils
    pkgs.containerd
    pkgs.cni
    pkgs.cni-plugins
  ];
}
