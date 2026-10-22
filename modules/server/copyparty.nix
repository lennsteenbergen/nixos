{ config, lib, pkgs, ... }:

{
  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.copyparty-lennsteenbergen = {
      sopsFile = ../../secrets/copyparty.yaml;
      key = "lennsteenbergen";
      owner = "copyparty";
    };
  };

  services.copyparty = {
    enable = true;

    settings = {
      i = "127.0.0.1";   
      p = [ 3923 ];
      e2dsa = true;      
      e2ts = true;       
    };

    accounts.lennsteenbergen.passwordFile = config.sops.secrets.copyparty-lennsteenbergen.path;

    volumes."/" = {
      path = "/mnt/2tb/copyparty";
      access = {
        r = "*";
        rw = [ "lennsteenbergen" ];
      };
    };  
  };

  systemd.tmpfiles.rules = [
    "d /mnt/2tb/copyparty 0750 copyparty copyparty - -"
  ];

  services.caddy.virtualHosts."files.lennsteenbergen.com".extraConfig = ''
    reverse_proxy 127.0.0.1:3923
  '';
}
