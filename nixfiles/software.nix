{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _7zz 
    alacritty
    android-studio
    android-tools
    appimage-run
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
    oscar
    prismlauncher
    pulseaudio
    python314
    python314Packages.pip
    rustdesk-flutter
    ryubing
    scrcpy
    steam
    texliveSmall
    thunderbird
    tor-browser
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
