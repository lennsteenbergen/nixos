{ config, pkgs, ... }:

{
  networking.networkmanager.ensureProfiles.profiles.eduroam-8e97c43f-3a70-44ca-962c-6a303341e35a = {
    "802-1x" = {
      eap = "peap;";
      phase2-auth = "mschapv2";
      identity = "lennsteenbergen@leerling.christelijklyceum.nl";
      # Do NOT hardcode your real password here.
      # Recommended: use sops-nix or agenix to inject this as an env var / secret file,
      # then reference it here. As a placeholder for now:
      password = "EliSaado-SomtodayAPI2010!";
    };
    connection = {
      id = "eduroam";
      interface-name = "wlp1s0"; # TODO: confirm this matches your wifi interface, check with `ip link`
      type = "wifi";
      uuid = "8e97c43f-3a70-44ca-962c-6a303341e35a";
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
}
