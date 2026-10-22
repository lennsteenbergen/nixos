{ config, lib, pkgs, ... }:

{
  services.uptime-kuma.enable = true;

  services.caddy.virtualHosts."status.lennsteenbergen.com".extraConfig = ''
    reverse_proxy 127.0.0.1:3001
  '';
}
