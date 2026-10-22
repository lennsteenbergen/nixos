{ config, lib, pkgs, ... }:

{
  services.matrix-continuwuity = {
    enable = true;
    settings.global = {
      server_name = "lennsteenbergen.com";
      address = [ "127.0.0.1" "::1" ];
      port = 8008;
      new_user_displayname_suffix = "";
      allow_announcements_check = true;
      trusted_servers = [ "utwente.io" "starstruck.systems" "matrix.org" ];

      well_known = {
        client = "https://matrix.lennsteenbergen.com";
        server = "matrix.lennsteenbergen.com:443";
      };
    };
  };

  services.caddy.virtualHosts = {
    "matrix.lennsteenbergen.com".extraConfig = ''
      reverse_proxy 127.0.0.1:8008
    '';

    "lennsteenbergen.com".extraConfig = ''
      reverse_proxy /.well-known/matrix/* 127.0.0.1:8008
    '';
  };
}
