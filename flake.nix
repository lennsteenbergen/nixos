{
  description = "thinkpad-nixos system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, spicetify-nix, sops-nix, ... }: {
    nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit spicetify-nix;
      };

      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        sops-nix.nixosModules.sops
      ];
    };
  };
}
