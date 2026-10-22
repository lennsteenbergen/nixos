{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    email = "lennsteenbergen10@gmail.com";

    virtualHosts = {
      "http://lennsteenbergen.com, https://lennsteenbergen.com".extraConfig = ''
        root * /home/lennsteenbergen/site
        file_server
        encode zstd gzip
      '';

      "http://www.lennsteenbergen.com, https://www.lennsteenbergen.com, http://lennsteenbergen.nl, https://lennsteenbergen.nl, http://www.lennsteenbergen.nl, https://www.lennsteenbergen.nl, http://lennsteenbergen.dev, https://lennsteenbergen.dev, http://www.lennsteenbergen.dev, https://www.lennsteenbergen.dev" = {
        logFormat = ''
          output discard
        '';
        extraConfig = ''
          redir https://lennsteenbergen.com{uri} permanent
        '';
      };
    };
  };

  # Let Caddy read files under /home
  users.users.lennsteenbergen.homeMode = "711";
  systemd.services.caddy.serviceConfig.ProtectHome = lib.mkForce false;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ]; # HTTP/3
}
