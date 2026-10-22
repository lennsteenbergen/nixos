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
      vpn-wg-key = { };
    };

    templates."wifi.env".content = ''
      SCHOOL_USER=${s.wifi-school-user}
      SCHOOL_PASS=${s.wifi-school-pass}
      UNIFI_USER=${s.unifi-user}
      UNIFI_PASS=${s.unifi-pass}
      HOME_PSK=${s.wifi-home-psk}
      WG_KEY=${s.vpn-wg-key}
    '';
  };

  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [ config.sops.templates."wifi.env".path ];

      profiles = {
        eduroam = {
          connection = {
            id = "eduroam";
            uuid = "b151f6c7-e782-4da3-af9d-d36e0ab94628";
            type = "wifi";
            autoconnect = true;
            secondaries = "5f40772d-3f28-4974-a535-238164523946;";
          };
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

        unifi = {
          connection = {
            id = "UniFi";
            uuid = "8d37bb52-9967-4b76-a8ea-7f657b247ddf";
            type = "wifi";
            autoconnect = true;
          };
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

        home = {
          connection = {
            id = "H369A6A71AD";
            uuid = "5ba8dee0-8aee-4745-b930-a774a1706d8f";
            type = "wifi";
            autoconnect = true;
          };
          wifi = { ssid = "H369A6A71AD"; mode = "infrastructure"; };
          wifi-security = { key-mgmt = "wpa-psk"; psk = "$HOME_PSK"; };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };

        vpn-eduroam = {
          connection = {
            id = "vpn-eduroam";
            uuid = "5f40772d-3f28-4974-a535-238164523946";
            type = "wireguard";
            interface-name = "wg-edu";
            autoconnect = false;
          };
          wireguard.private-key = "$WG_KEY";
          "wireguard-peer.3LRJJIXLn2CPN/wrL0SEiE07Oqezga7TnRU7mgoZ2nE=" = {
            endpoint = "77.160.138.6:51820";
            allowed-ips = "0.0.0.0/0;";
            persistent-keepalive = 25;
          };
          ipv4 = {
            method = "manual";
            address1 = "192.168.8.2/32";
            dns = "192.168.8.1;";
          };
          ipv6.method = "disabled";
        };
      };
    };
  };
}
