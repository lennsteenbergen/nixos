{
  description = "thinkpad-nixos system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, spicetify-nix, sops-nix, noctalia, ... }: {
    nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit spicetify-nix noctalia;
      };

      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        sops-nix.nixosModules.sops
        noctalia.nixosModules.default
      ];
    };
  };
}
