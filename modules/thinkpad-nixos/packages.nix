{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _7zz 
    android-tools
    appimage-run
    curl
    deno
    ffmpeg
    git
    gnupg
    lm_sensors
    mtr
    nodejs_24
    openvpn
    pulseaudio
    python314
    python314Packages.pip
    usbutils
    vim
    wget
  ];
}
