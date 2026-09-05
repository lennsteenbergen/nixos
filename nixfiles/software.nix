{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _7zz 
    alacritty
    android-tools
    appimage-run
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
    libreoffice-stable
    lm_sensors
    mpv
    mtr
    neovim
    nh
    nodejs_24
    oscar
    prismlauncher
    pulseaudio
    python314
    python314Packages.pip
    rustdesk-flutter
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
