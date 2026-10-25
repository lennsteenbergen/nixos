# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/server/caddy.nix
      ../../modules/server/continuwuity.nix
      ../../modules/server/copyparty.nix
      ../../modules/server/disks.nix
      ../../modules/server/gitlab.nix
      ../../modules/server/gnupg.nix
      ../../modules/server/jellyfin.nix
      ../../modules/server/mc-newnewserver.nix
      ../../modules/server/networking.nix
      ../../modules/server/nix-command.nix
      ../../modules/server/openssh.nix
      ../../modules/server/packages.nix
      ../../modules/server/somtoday.nix
      ../../modules/server/uptimekuma.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "server"; # Define hostname

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Users
  users.users."lennsteenbergen" = {
    isNormalUser = true;
    description = "Lenn Steenbergen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  system.stateVersion = "26.05"; # Don't change this for now

}
