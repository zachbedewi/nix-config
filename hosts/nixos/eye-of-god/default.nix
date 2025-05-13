# ========================================
#
# Eye Of God - Primary machine
#
# ========================================

{
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    #
    # ===== Hardware =====
    #
    ./hardware-configuration.nix

    #
    # ===== Miscellaneous =====
    #
    (map lib.custom.relativeToRoot [
      #
      # ===== Required =====
      #
      "hosts/common/core"

      #
      # ===== Optional =====
      #
      "hosts/common/optional/audio.nix"
    ])
  ];

  hostSpec = {
    hostName = "eye-of-god";
    wifi = lib.mkForce true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.ntp.enable = true;
  services.automatic-timezoned.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "skitzo";

  environment.systemPackages = with pkgs; [
    firefox
    neovim
    alejandra
    statix
    deadnix
  ];

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
