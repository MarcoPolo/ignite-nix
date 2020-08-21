{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ignited;
  ignite = import ../ignite.nix { inherit pkgs; };
in {
  options.services.ignited = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables ignited service in the background
      '';
    };

  };

  config = {
    users.groups.ignited = { };

    systemd.services.ignited = {
      wantedBy = optional cfg.enable "multi-user.target";
      serviceConfig = {
        User = "root";
        WorkingDirectory = "${pkgs.containerd}/bin";
        ExecStartPre = ''
        ${pkgs.bash}/bin/bash -c 'mkdir -p /opt/cni && ln -sf ${pkgs.cni-plugins}/bin /opt/cni/;'
        '';
        ExecStart = [
          # "${pkgs.coreutils}/bin/pwd | echo"
          # "${pkgs.coreutils}/bin/ls ${pkgs.containerd}/bin | echo"
          # ''${pkgs.bash}/bin/bash -c "${ignite}/bin/ignited daemon"''
          # ''
          #   ${pkgs.bash}/bin/bash -c "PATH=${pkgs.containerd}/bin:$PATH ${ignite}/bin/ignited daemon"''
          ''${ignite}/bin/ignited daemon --log-level trace''
        ];
        ExecReload = [ "" "${pkgs.procps}/bin/kill -s HUP $MAINPID" ];
      };

      path = [
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
    };
  };
}
