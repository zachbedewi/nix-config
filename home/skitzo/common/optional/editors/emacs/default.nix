{
  pkgs,
  ...
}:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable;
  };

  home.packages = with pkgs; [
    nil
  ];

  home.file.".emacs.d" = {
    source = ./config;
    recursive = true;
  };
}
