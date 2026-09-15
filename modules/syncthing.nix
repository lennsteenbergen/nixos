{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "lennsteenbergen";
    dataDir = "/home/lennsteenbergen";
    configDir = "/home/lennsteenbergen/.config/syncthing";
    openDefaultPorts = true; # opens 22000 (sync) and 21027 (discovery) in the firewall
  };
}
