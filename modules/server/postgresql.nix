{ config, pkgs, ... }:
{
  sops.secrets.keycloak_db_password = {
    sopsFile = ../../secrets/keycloak.yaml;
    owner = "postgres";   
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "keycloak" ];
    ensureUsers = [
      {
        name = "keycloak";
        ensureDBOwnership = true; 
      }
    ];
  };

  systemd.services.postgresql-keycloak-password = {
    description = "Set keycloak postgres password from sops";
    after = [ "postgresql.service" "postgresql-setup.service" ];
    requires = [ "postgresql.service" "postgresql-setup.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "postgres";
    };
    script = ''
      password=$(cat ${config.sops.secrets.keycloak_db_password.path})
      ${config.services.postgresql.package}/bin/psql -v ON_ERROR_STOP=1 -tA <<EOF
        ALTER USER keycloak WITH PASSWORD '$password';
      EOF
    '';
  };
}
