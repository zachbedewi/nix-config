{
  nixpkgs.config.allowUnfree = true;

  # Auto upgrae the nix-daemon service
  services.nix-daemon.enable = true;
  nix.gc.automatic = false;
}
