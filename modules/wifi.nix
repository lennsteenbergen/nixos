{ config, ... }:
let
  s = config.sops.placeholder;
in
{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      wifi-school-user = { };
      wifi-school-pass = { };
      unifi-user = { };
      unifi-pass = { };
      wifi-home-psk = { };
    };

    templates."wifi.env".content = ''
      SCHOOL_USER=${s.wifi-school-user}
      SCHOOL_PASS=${s.wifi-school-pass}
      UNIFI_USER=${s.unifi-user}
      UNIFI_PASS=${s.unifi-pass}
      HOME_PSK=${s.wifi-home-psk}
    '';
  };

  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [ config.sops.templates."wifi.env".path ];

      profiles = {
        # 1. WPA2 Enterprise, PEAP + MSCHAPv2, no CA / anonymous identity
        school = {
          connection = { id = "school"; type = "wifi"; autoconnect = true; };
          wifi = { ssid = "eduroam"; mode = "infrastructure"; };
          wifi-security.key-mgmt = "wpa-eap";
          "802-1x" = {
            eap = "peap;";
            phase2-auth = "mschapv2";
            identity = "$SCHOOL_USER";
            password = "$SCHOOL_PASS";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };

        # 2. WPA2/3 Enterprise
        unifi = {
          connection = { id = "unifi"; type = "wifi"; autoconnect = true; };
          wifi = { ssid = "UniFi"; mode = "infrastructure"; };
          wifi-security.key-mgmt = "wpa-eap";
          "802-1x" = {
            eap = "peap;";
            phase2-auth = "mschapv2";
            identity = "$UNIFI_USER";
            password = "$UNIFI_PASS";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };

        # 3. Plain WPA2 personal
        home = {
          connection = { id = "home"; type = "wifi"; autoconnect = true; };
          wifi = { ssid = "H369A6A71D"; mode = "infrastructure"; };
          wifi-security = { key-mgmt = "wpa-psk"; psk = "$HOME_PSK"; };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
      };
    };
  };
}
