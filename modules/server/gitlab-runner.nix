{ config, lib, pkgs, ... }:

{
  services.gitlab-runner = {
    enable = true;

    settings = {
      concurrent = 2;
      check_interval = 3;
    };

    services.host = {
      executor = "shell";
      authenticationTokenConfigFile = "/etc/gitlab-runner/host.env";
      buildsDir = "/var/lib/gitlab-builds";
    };
  };

  systemd.services.gitlab-runner = {
    path = [
      "/run/current-system/sw"   # environment.systemPackages
      "/run/wrappers"            # setuid wrappers (sudo etc.)
    ];

    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "lennsteenbergen";
      Group = "users";
      ProtectHome = lib.mkForce false;
      ProtectSystem = lib.mkForce false;
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/gitlab-builds 0755 lennsteenbergen users -"
  ];

}
