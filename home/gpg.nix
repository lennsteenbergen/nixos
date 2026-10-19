{ pkgs, ... }:

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "0A34FDB226455C3691A166886D585F0E8F62131F" ];
    pinentry.package = pkgs.pinentry-qt;
  };
}
