{ config, lib, pkgs, ... }:

{
  services.jellyfin.enable = true;

  services.caddy.virtualHosts."media.lennsteenbergen.com".extraConfig = ''
    reverse_proxy 127.0.0.1:8096
  '';
}
