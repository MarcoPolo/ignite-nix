# { pkgs ? import <nixpkgs> { } }:
# pkgs.stdenv.mkDerivation {
#   name = "ignite";
#   buildPhase = ''
#     mkdir -p $out/bin
#   '';
#   buildInputs = with pkgs; [ makeWrapper ];
#   installPhase = ''
#     cp ignite $out/bin/ignite
#     cp ignited $out/bin/ignited

#     echo "cni Bin as at" ${pkgs.cni-plugins}/bin
#     wrapProgram $out/bin/ignited \
#             --set LD_PRELOAD    "${pkgs.libredirect}/lib/libredirect.so" \
#             --set NIX_REDIRECTS "/opt/cni/bin=${pkgs.cni-plugins}/bin"
#     wrapProgram $out/bin/ignite \
#             --set LD_PRELOAD    "${pkgs.libredirect}/lib/libredirect.so" \
#             --set NIX_REDIRECTS "/opt/cni/bin=${pkgs.cni-plugins}/bin:/opt/cni/bin/loopback=${pkgs.cni-plugins}/bin/loopback"
#   '';
#   src = builtins.path {
#     path = ./.;
#     name = "ignite";
#   };
# }
{ system ? builtins.currentSystem, pkgs ? import <nixpkgs> { inherit system; } }:
pkgs.buildGoModule rec {
  pname = "ignite";
  version = "0.7.1";
  src = pkgs.fetchFromGitHub {
    owner = "weaveworks";
    repo = "ignite";
    rev = "9dcf57ed875bd49e566a3692255130d571c084bd";
    sha256 = "sha256:13rh02a701dgv20nim08mh3sxc778kx4hadkf7wkn1x4xjpz4bjb";
    # sha256 = pkgs.lib.fakeSha256;
    # rev = "v${version}";
    # sha256 = "sha256:12lka6mxrl0my98fxylfqcj87214p0hnfpjp068agqrv4473054n";
    # rev = "c17a99c7bbff8b9d1e96594e5f6356de61bb98fd";
    # sha256 = "sha256:0l5yslaic02pr3b45f85ydz1w9891gy63068p5v7ycy9irzvhv5v";
  };

  vendorSha256 = null;
  buildInputs = [ pkgs.makeWrapper ];
  # patches = [ ./configurable-cni-paths.diff ];
  # preFixup = ''
  #   wrapProgram $out/bin/ignited \
  #           --set LD_PRELOAD    "${pkgs.libredirect}/lib/libredirect.so" \
  #           --set NIX_REDIRECTS "/opt/cni/bin=${pkgs.cni-plugins}"
  #   wrapProgram $out/bin/ignite \
  #           --set LD_PRELOAD    "${pkgs.libredirect}/lib/libredirect.so" \
  #           --set NIX_REDIRECTS "/opt/cni/bin=${pkgs.cni-plugins}"
  # '';
}
