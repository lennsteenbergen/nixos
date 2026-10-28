{ lib, ... }:

let
  root = "/home/lennsteenbergen/somtoday";
  domain = "nontoday.nl";

  envs = {
    prod       = [ "leerling.${domain}" ];
    nightly    = [ "leerling.nightly.${domain}"    "nightly.${domain}" ];
    test       = [ "leerling.test.${domain}"       "test.${domain}" ];
    acceptatie = [ "leerling.acceptatie.${domain}" "acceptatie.${domain}" ];
    inkijk     = [ "leerling.inkijk.${domain}"     "inkijk.${domain}" ];
    inkijk2    = [ "leerling.inkijk2.${domain}"    "inkijk2.${domain}" ];
    regressie  = [ "leerling.regressie.${domain}"  "regressie.${domain}" ];
  };

  scanVersions = name:
    let dir = "${root}/${name}"; in
    if !builtins.pathExists dir then [ ]
    else
      lib.mapAttrsToList (n: _: lib.removePrefix "Leerling_" n)
        (lib.filterAttrs
          (n: t: t == "directory" && lib.hasPrefix "Leerling_" n)
          (builtins.readDir dir));

  sortNewest = vs: lib.sort (a: b: lib.versionOlder b a) vs;

  currentDir = name:
    let
      vs = scanVersions name;
      latest = lib.head (sortNewest vs);
    in
    if builtins.pathExists "${root}/${name}/current" || vs == [ ]
    then "${root}/${name}/current"
    else "${root}/${name}/Leerling_${latest}";

  subdomain = v:
    lib.replaceStrings [ "." "_" ] [ "-" "-" ] (lib.removeSuffix ".0" v);

  site = dir: {
    extraConfig = ''
      encode zstd gzip
      root * ${dir}
      try_files {path} /index.html
      file_server
    '';
  };

  mkHosts = name: host: withVersions:
    { ${host} = site (currentDir name); }
    // lib.optionalAttrs withVersions (lib.listToAttrs (map
      (v: lib.nameValuePair "${subdomain v}.${host}"
        (site "${root}/${name}/Leerling_${v}"))
      (scanVersions name)));

  mkEnvHosts = name: hosts:
    lib.mergeAttrsList (lib.imap0 (i: h: mkHosts name h (i == 0)) hosts);

  envHosts = lib.mergeAttrsList (lib.mapAttrsToList mkEnvHosts envs);

  extraHosts = {
    "somtoday.${domain}".extraConfig = ''
      reverse_proxy localhost:8080
    '';
  };
in
{
  services.caddy = {
    enable = true;
    virtualHosts = envHosts // extraHosts;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
