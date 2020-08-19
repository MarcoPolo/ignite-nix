{ pkgs ? import <nixpkgs> { } }:
let ignite = import ./ignite.nix { inherit pkgs; };
in pkgs.mkShell {
  CNI_PATH = "${pkgs.cni-plugins}/bin";
  FOOO = "FOOO";
  buildInputs = [
    # pkgs.bash
    # pkgs.coreutils
    pkgs.containerd
    # pkgs.openssh
    # pkgs.e2fsprogs
    # pkgs.gnutar
    # pkgs.iptables
    # pkgs.devicemapper
    # pkgs.mount
    pkgs.runc
    pkgs.hello
    ignite
    pkgs.git
    pkgs.binutils
    pkgs.cni
    pkgs.cni-plugins
  ];
}
