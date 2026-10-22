{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _7zz 
    android-tools
    curl
    ffmpeg
    git
    gnupg
    lm_sensors
    mtr
    nodejs_24
    pulseaudio
    python314
    python314Packages.pip
    usbutils
    vim
    wget
  ];
}
