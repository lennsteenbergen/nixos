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
    thunderbird
    tor-browser
    vesktop
    vlc
    vscode
    zed-editor
  ];
}
