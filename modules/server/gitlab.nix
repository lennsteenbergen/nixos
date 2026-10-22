{ config, lib, pkgs, ... }:

{
  services.gitlab = {
    enable = true;

    host = "git.lennsteenbergen.dev";
    port = 443;
    https = true;

    initialRootPasswordFile = "/var/lib/gitlab/secrets/root_password";

    secrets = {
      secretFile = "/var/lib/gitlab/secrets/secret";
      dbFile = "/var/lib/gitlab/secrets/db";
      otpFile = "/var/lib/gitlab/secrets/otp";
      jwsFile = "/var/lib/gitlab/secrets/jws";
      activeRecordPrimaryKeyFile =
        "/var/lib/gitlab/secrets/activeRecordPrimaryKey";
      activeRecordDeterministicKeyFile =
        "/var/lib/gitlab/secrets/activeRecordDeterministicKey";
      activeRecordSaltFile =
        "/var/lib/gitlab/secrets/activeRecordSalt";
    };
  };

  networking.firewall.allowedTCPPorts = [ 2222 ];

  services.caddy.virtualHosts."git.lennsteenbergen.dev".extraConfig = ''
    reverse_proxy unix//run/gitlab/gitlab-workhorse.socket {
      header_up X-Forwarded-Proto https
      header_up X-Forwarded-Ssl on
    }
  '';
}
