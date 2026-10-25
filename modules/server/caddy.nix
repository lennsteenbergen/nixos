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
    };
  };

  users.users.lennsteenbergen.homeMode = "711";
  systemd.services.caddy.serviceConfig.ProtectHome = lib.mkForce false;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ]; # HTTP/3
}

