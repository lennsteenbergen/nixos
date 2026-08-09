{ config, pkgs, ... }:

{
  # Open TCP ports
  networking.firewall.allowedTCPPorts = [
    22
    10250
  ];

  # Open UDP ports
  networking.firewall.allowedUDPPorts =  [];

}
