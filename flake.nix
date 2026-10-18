{
  description = "Lenn's NixOS system configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, spicetify-nix, sops-nix, ... }: {
    nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit spicetify-nix; };
      modules = [
        ./hosts/thinkpad-nixos/configuration.nix
        ./hosts/thinkpad-nixos/hardware-configuration.nix
      ];
    };

    nixosConfigurations."laptop-lenn" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit spicetify-nix; };
      modules = [
        ./hosts/laptop-lenn/configuration.nix
        ./hosts/laptop-lenn/hardware-configuration.nix
      ];
    };
  };
}
