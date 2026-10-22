{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.enableRedistributableFirmware = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
  ];
}
