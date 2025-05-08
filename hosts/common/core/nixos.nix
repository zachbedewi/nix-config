{
  lib,
  ...
}:
{
  environment.enableAllTerminfo = true;

  security.sudo.extraConfig = ''
    Defaults lecture = never
    Defaults pwfeedback
    Defaults timestamp_timeout=120
    Defaults env_keep+=SSH_AUTH_SOCK
  '';

  #
  # ===== Nix Helper =====
  #
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 20d --keep 20";
  };

  #
  # ===== Localization =====
  #
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  time.timeZone = lib.mkDefault "America/Chicago";
}
