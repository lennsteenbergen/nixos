{ config, lib, pkgs, ... }:
let
  spicetify-nix = import (builtins.fetchTarball {
    url = "https://github.com/Gerg-L/spicetify-nix/archive/master.tar.gz";
  }) { };
in {
  imports = [
    spicetify-nix.nixosModules.spicetify
  ];

  programs.spicetify = {
    enable = true;

    theme = spicetify-nix.packages.themes.starryNight;
    colorScheme = "Base";

    enabledExtensions = with spicetify-nix.packages.extensions; [
      adblockify
    ];
  };
}
