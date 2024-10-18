# Cocoon: Macbook Pro 2021 14-inch M1 32G, work assigned.
_:
let
  hostname = "cocoon";
in {
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}