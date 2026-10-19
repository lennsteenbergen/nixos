{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    brave
    btop
    fastfetch
    gimp
    htop
    libreoffice-stable
    nh
    oscar
    prismlauncher
    scrcpy
    spotdl
    thunderbird
    tor-browser
    vesktop
    vlc
    vscode
    zed-editor
  ];
}
