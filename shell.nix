# Custom shell for bootstrapping on new hosts, modifying nix-config, and secrets management
{
  pkgs ?
  # If pkgs is not defined, instantiate nixpkgs from locked commit
  let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";

    nativeBuildInputs = builtins.attrValues {
      inherit
        (pkgs)
        nix
        home-manager
        nh
        git
        just
        pre-commit
        deadnix
        sops
        yq-go
        bats
        age
        ssh-to-age
        ;
    };
  };
}
