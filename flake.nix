{
  description = "Lenn's NixOS system configs";

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
      specialArgs = { inherit spicetify-nix noctalia; };
      modules = [
        ./hosts/thinkpad-nixos/configuration.nix
        ./hosts/thinkpad-nixos/hardware-configuration.nix
        sops-nix.nixosModules.sops
        noctalia.nixosModules.default
      ];
    };

    nixosConfigurations."laptop-lenn" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit spicetify-nix noctalia; };
      modules = [
        ./hosts/laptop-lenn/configuration.nix
        ./hosts/laptop-lenn/hardware-configuration.nix
        sops-nix.nixosModules.sops
        noctalia.nixosModules.default
      ];
    };
  };
}
