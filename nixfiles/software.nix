# Stable packages, for unstable see unstable.nix.

{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _7zz 
    alacritty
    android-studio
    android-tools
    blender
    brave
    btop
    curl
    deno
    fastfetch
    ffmpeg
    git
    gimp
    gnupg
    htop
    ipe
    jetbrains.idea
    libreoffice-fresh
    lm_sensors
    mpv
    mtr
    neovim
    nerd-fonts.jetbrains-mono
    nh
    nodejs_24
    prismlauncher
    pulseaudio
    python314
    python314Packages.pip
    rustdesk-flutter
    scrcpy
    steam
    texliveSmall
    thunderbird
    tree
    usbutils
    vesktop
    vim
    vlc
    vscode
    wget
    wireshark
    xournalpp
    zed-editor
  ];
}
