{ config, lib, pkgs, ... }:

with lib;

let cfg = config.services.containerd;
in {
  options.services.containerd = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables containerd service in the background
      '';
    };

  };

  config = {
    users.groups.containerd = { };

    systemd.services.containerd = {
      wantedBy = optional cfg.enable "multi-user.target";
      serviceConfig = {
        ExecStart = [
          ""
          ''
            ${pkgs.containerd}/bin/containerd
          ''
        ];
        ExecReload = [ "" "${pkgs.procps}/bin/kill -s HUP $MAINPID" ];
      };

      path = [ pkgs.kmod pkgs.containerd pkgs.runc ];
    };

    systemd.sockets.containerd = {
      description = "containerd socket for the API";
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenStream = "/run/containerd/containerd.sock";
        SocketMode = "0660";
        SocketUser = "root";
        SocketGroup = "containerd";
      };
    };
  };
}
