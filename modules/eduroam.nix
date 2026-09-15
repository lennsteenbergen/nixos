{ config, pkgs, ... }:
{
  sops.secrets.wifi_eduroam = {
    sopsFile = ../secrets/wifi.yaml;
    key = "eduroam_password";
  };

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.secrets.wifi_eduroam.path ];

    profiles.eduroam-61c069c2-a322-4d58-a99a-ecdb1ca78ceb = {
      "802-1x" = {
        eap = "peap";
        phase2-auth = "mschapv2";
        identity = "lennsteenbergen@leerling.christelijklyceum.nl";
        password = "$eduroam_password";
      };

      connection = {
        id = "eduroam";
        interface-name = "wlp1s0";
        type = "wifi";
        uuid = "61c069c2-a322-4d58-a99a-ecdb1ca78ceb";
      };

      ipv4 = {
        method = "auto";
      };

      ipv6 = {
        addr-gen-mode = "default";
        method = "auto";
      };

      proxy = { };

      wifi = {
        mode = "infrastructure";
        ssid = "eduroam";
      };

      wifi-security = {
        auth-alg = "open";
        key-mgmt = "wpa-eap";
      };
    };
  };
}
