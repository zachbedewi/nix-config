{
  config,
  pkgs,
  ...
}:
{
  home.stateVersion = "24.05";
  home.username = "zbbedewi";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.htop
  ];
}