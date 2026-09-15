{ config, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://192.168.1.169:6443";
    tokenFile = "/etc/k3s-token";
  };
}
