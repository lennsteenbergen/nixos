{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "server";
    useDHCP = false;
    networkmanager.enable = false;
    tempAddresses = "disabled";

    interfaces.enp6s0 = {
      ipv4.addresses = [{
        address = "192.168.1.169";
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = "2a02:a442:8ba:0::169";
        prefixLength = 64;
      }];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp6s0";
    };
    defaultGateway6 = {
      address = "fe80::962a:6fff:fed0:1ca3";
      interface = "enp6s0";
    };

    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
      "2606:4700:4700::1111"
      "2620:fe::fe"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
    };
  };
}
