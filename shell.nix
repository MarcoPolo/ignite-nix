{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs                  # and use them again!
    {
      overlays = [
        (_: pkgs:
          {
            niv = import sources.niv { }; # use the sources :)
          }
        )
      ];
      config = { };
    }
}: # import the sources
let ignite = import ./ignite.nix { inherit pkgs; };
in pkgs.mkShell {
CNI_PATH = "${pkgs.cni-plugins}/bin";
FOOO = "FOOO";
buildInputs = [
pkgs.umount
pkgs.bash
pkgs.coreutils
pkgs.containerd
pkgs.openssh
pkgs.e2fsprogs
pkgs.gnutar
pkgs.iptables
pkgs.devicemapper
pkgs.mount
pkgs.runc
pkgs.hello
ignite
pkgs.git
pkgs.binutils
pkgs.cni
pkgs.cni-plugins
];
}
