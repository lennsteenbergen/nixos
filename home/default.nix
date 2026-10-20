{ ... }:

{
  imports = [
    ./git.nix
    ./gpg.nix
    ./packages.nix
    ./spicetify.nix
    ./oh-my-posh.nix
  ];

  home.username = "lennsteenbergen";
  home.homeDirectory = "/home/lennsteenbergen";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
