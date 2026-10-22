
{ config, lib, pkgs, ... }:

{
  systemd.services.mc-newnewserver = {
    description = "Paper Minecraft Server: newnewserver";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      User = "lennsteenbergen";
      WorkingDirectory = "/home/lennsteenbergen/newnewserver";

      ExecStart = lib.concatStringsSep " " [
        "${pkgs.jdk25}/bin/java"
        "-Xms256M"
        "-Xmx1G"
        "-XX:+UseG1GC"
        "-XX:MaxGCPauseMillis=200"
        "-XX:ActiveProcessorCount=2"
        "-XX:ParallelGCThreads=2"
        "-XX:ConcGCThreads=1"
        "-XX:+ExitOnOutOfMemoryError"
        "-jar"
        "paper.jar"
        "--nogui"
      ];

      Restart = "on-failure";
      RestartSec = 10;
      TimeoutStopSec = 120;

      # Keep resource usage modest
      CPUQuota = "150%";
      MemoryMax = "1536M";
      MemorySwapMax = "512M";

      # Security
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = "read-only";
      ReadWritePaths = [ "/home/lennsteenbergen/newnewserver" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}
