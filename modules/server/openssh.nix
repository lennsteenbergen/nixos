{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;

    settings = {
      PubkeyAuthentication = true;
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.lennsteenbergen.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEb3ZzC4yFbqNELzU1y8pXA8lVavpHK9hypAakb1v9dO openpgp:0x81A343B8"
  ];

  networking.firewall.allowedTCPPorts = [ 22 ];
}
