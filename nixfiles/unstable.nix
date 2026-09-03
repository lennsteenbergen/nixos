{ config, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = [
    unstable.oscar
  ];
}
