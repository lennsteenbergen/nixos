{ config, pkgs, ... }:
{
services.keycloak = {
  enable = true;

  database = {
    type = "postgresql";
    host = "localhost";
    port = 5432;
    name = "keycloak";
    username = "keycloak";
    passwordFile = config.sops.secrets.keycloak_db_password.path;
    createLocally = false;   # you created db/user yourself
  };

  settings = {
    hostname = "auth.nontoday.nl";
    http-enabled = true;
    http-port = 8091;
    proxy-headers = "xforwarded";                # behind caddy
  };
  initialAdminPassword = "changeme";
};

systemd.services.keycloak = {
  after = [ "postgresql-keycloak-password.service" ];
  requires = [ "postgresql-keycloak-password.service" ];
};
}
