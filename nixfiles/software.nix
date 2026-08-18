# Stable packages, for unstable see unstable.nix.

{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    alacritty
    android-studio
    blender
    brave
    curl
    fastfetch
    git
    gimp
    gnupg
    htop
    ipe
    jetbrains.idea
    libreoffice-fresh
    neovim
    nerd-fonts.jetbrains-mono
    nh
    python314
    python314Packages.pip
    rustdesk-flutter
    steam
    texliveSmall # Dependency of Ipe
    thunderbird
    tree
    usbutils
    vesktop
    vim
    vlc
    vscode
    wget
    zed-editor
  ];
}
