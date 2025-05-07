{
  description = "Zach's Nix Configuration.";

  inputs = {
    #
    # ===== Official NixOS, Darwin, and Home Manager package sources =====
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # The next two inputs are for pinning to nixpkgs stable or unstable regardless of what the default
    # nixpkgs is set to.
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ===== Pre-commit Hooks =====
    #
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ===== Secret Management =====
    #
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/zachbedewi/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      #
      # ===== Architectures =====
      #
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        # Uncomment when MacOS hosts are added
        # "aarch64-darwin"
      ];

      #
      # ===== Extending lib with lib.custom =====
      #
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
    in
    {
      #
      # ===== Overlays =====
      #
      # Custom modifications/overrides to upstream packages
      overlays = import ./overlays { inherit inputs; };

      #
      # ===== Host Configurations =====
      #
      nixosConfigurations.eye-of-god = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs outputs lib;
        };
        modules = [
          ./hosts/eye-of-god
        ];
      };

      #
      # ===== Formatting and Pre-commit Hooks =====
      #
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./checks.nix { inherit inputs system pkgs; }
      );

      #
      # ===== Dev Shells =====
      #
      # Custom shell for bootstrapping on new hosts, modifying nix-config, and secrets management
      devShells = forAllSystems (
        system:
        import ./shell.nix {
          pkgs = nixpkgs.legacyPackages.${system};
          checks = self.checks.${system};
        }
      );
    };
}
