{ config, lib, pkgs, ... }:

{
  sops.secrets."oidc_client_secret" = {
    sopsFile = ../../secrets/gitlab.yaml;
    owner = "gitlab";
  };

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

    extraConfig.omniauth = {
      enabled = true;
      allow_single_sign_on = [ "openid_connect" ];
      block_auto_created_users = false;
      providers = [
        {
          name = "openid_connect";
          label = "Keycloak";
          args = {
            name = "openid_connect";
            scope = [ "openid" "profile" "email" ];
            response_type = "code";
            issuer = "https://auth.nontoday.nl/realms/nontoday";
            discovery = true;
            client_auth_method = "query";
            uid_field = "preferred_username";
            pkce = true;
            client_options = {
              identifier = "gitlab";
              secret._secret = config.sops.secrets."oidc_client_secret".path;
              redirect_uri = "https://git.lennsteenbergen.dev/users/auth/openid_connect/callback";
            };
          };
        }
      ];
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
