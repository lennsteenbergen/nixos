{ config, pkgs, ... }:

{
  # Open TCP ports
  networking.firewall.allowedTCPPorts = [
    22
  ];

  # Open UDP ports
  networking.firewall.allowedUDPPorts = [
    22
  ];

}
