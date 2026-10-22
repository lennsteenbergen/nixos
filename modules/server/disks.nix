{ config, pkgs, ... }:

{
  fileSystems."/mnt/t7" = {
    device = "/dev/disk/by-uuid/a90910c9-3da6-4925-9862-9f74c558373a";
    fsType = "btrfs";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.device-timeout=5s"
    ];
  };

  fileSystems."/mnt/2tb" = {
    device = "/dev/disk/by-uuid/23a4c1d7-3013-47ad-9267-0e867a73efd4";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.device-timeout=5s"
    ];
  };
}
