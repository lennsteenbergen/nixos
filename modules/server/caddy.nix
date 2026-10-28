{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    email = "lennsteenbergen10@gmail.com";

    virtualHosts = {
      "lennsteenbergen.com".extraConfig = ''
        root * /home/lennsteenbergen/site
        file_server
        encode zstd gzip
      '';

      "www.lennsteenbergen.com, lennsteenbergen.nl, www.lennsteenbergen.nl, lennsteenbergen.dev, www.lennsteenbergen.dev".extraConfig = ''
        redir https://lennsteenbergen.com{uri} permanent
      '';

      "chat.lennsteenbergen.com".extraConfig = ''
        root * /home/lennsteenbergen/sable
        file_server
        encode zstd gzip
      '';

      "nightly.nontoday.nl".extraConfig = ''
      root * /home/lennsteenbergen/nightly
      encode zstd gzip
      try_files {path} /index.html
      file_server
      '';

      "acceptatie.nontoday.nl".extraConfig = ''
      root * /home/lennsteenbergen/acceptatie
      encode zstd gzip
      try_files {path} /index.html
      file_server
      '';
      "nontoday.nl".extraConfig = ''
        reverse_proxy 127.0.0.1:7575
      '';
      "api.nontoday.nl".extraConfig = ''
        reverse_proxy 127.0.0.1:8090
      '';
      "auth.nontoday.nl".extraConfig = ''
        reverse_proxy 127.0.0.1:8091
      '';
    };
  };

  users.users.lennsteenbergen.homeMode = "711";
  systemd.services.caddy.serviceConfig.ProtectHome = lib.mkForce false;

  networking.firewall.allowedTCPPorts = [ 80 443 8080 8081 ];
  networking.firewall.allowedUDPPorts = [ 443 8080 8081 ]; # HTTP/3
}

