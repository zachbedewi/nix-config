{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.hostSpec = {
    # Data variables that don't dictate configuration settings
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    email = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "The email of the user";
    };
    work = lib.mkOption {
      default = { };
      type = lib.types.attrsOf lib.types.anything;
      description = "An attribute set of work-related information if isWork is true";
    };
    networking = lib.mkOption {
      default = { };
      type = lib.types.attrsOf lib.types.anything;
      description = "An attribute set of networking information";
    };
    wifi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate if a host has wifi";
    };
    domain = lib.mkOption {
      type = lib.types.str;
      description = "User to indicate if a host has wifi";
    };
    userFullName = lib.mkOption {
      type = lib.types.str;
      description = "The full name of the user";
    };
    handle = lib.mkOption {
      type = lib.types.str;
      description = "The handle of the user (eg: github user)";
    };
    home = lib.mkOption {
      type = lib.types.str;
      description = "The home directory of the user";
      default =
        let
          user = config.hostSpec.username;
        in
        if pkgs.stdenv.isLinux then "/home/${user}" else "/Users/${user}";
    };
    persistFolder = lib.mkOption {
      type = lib.types.str;
      description = "The folder to persist data if impermanence is enabled";
      default = "";
    };

    # Configuration Settings
    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "User to indicate a minimal host";
    };
    isMobile = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a mobile host";
    };
    isProduction = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a production host";
    };
    isServer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a server host";
    };
    isWork = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that uses work resources";
    };
    isDarwin = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a bost that is darwin";
    };
    useYubikey = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate if the host uses a yubikey";
    };
  };
}
