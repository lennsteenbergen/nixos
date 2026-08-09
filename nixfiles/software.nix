{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    alacritty
    brave
    curl
    fastfetch
    git
    gimp
    gnupg
    htop
    libreoffice-fresh
    neovim
    nerd-fonts.jetbrains-mono
    nh
    python314
    python314Packages.pip
    rustdesk-flutter
    steam
    thunderbird
    tree
    usbutils
    vesktop
    vim
    vlc
    vscode
    wget
    ytmdesktop
  ];
}
