{ lib, ... }:

let
  base = "/home/lennsteenbergen/somtoday";
  domain = "leerling.nontoday.nl";

  versions = [
    "2.0.0" "2.0.1" "2.0.2" "2.0.3" "2.0.6" "2.0.7"
    "2.1.0" "2.1.2" "2.1.3" "2.1.4" "2.1.5"
    "2.2.0" "2.3.0" "2.3.1" "2.3.2" "2.4.0" "2.5.0" "2.6.0" "2.6.1"
    "2.7.0" "2.8.0" "2.9.0"
    "2.10.0" "2.10.1" "2.11.0" "2.12.0" "2.13.0" "2.13.1"
    "2.14.0" "2.15.0" "2.16.0" "2.17.0" "2.18.0" "2.19.0" "2.20.0"
    "2.21.0" "2.22.0" "2.23.0" "2.24.0" "2.25.0"
  ];

  subdomain = v: lib.replaceStrings [ "." ] [ "-" ] (lib.removeSuffix ".0" v);

  mkHost = v: lib.nameValuePair "${subdomain v}.${domain}" {
    extraConfig = ''
      encode zstd gzip
      root * ${base}/Leerling_${v}
      try_files {path} /index.html
      file_server
    '';
  };

  versionHosts = lib.listToAttrs (map mkHost versions);

  extraHosts = {
    "somtoday.nontoday.nl".extraConfig = ''
      reverse_proxy localhost:8080
    '';

    "leerling.nontoday.nl".extraConfig = ''
      root * ${base}/Leerling_2.25.0
      encode zstd gzip
      try_files {path} /index.html
      file_server
    '';
  };
in
{
  services.caddy = {
    enable = true;
    virtualHosts = versionHosts // extraHosts;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
