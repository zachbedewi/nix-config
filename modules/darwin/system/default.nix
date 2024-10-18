# MacOS System Configuration
# 
# All Darwin configuration options documented here:
# https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
# Incomplete list of MacOS `defaults` commands:
# https://github.com/yannbertrand/macos-defaults
{...}: {
  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      dock = {
        # Autohide dock with no animation or delay
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;

        # Remove open/close animations and resize icons
        launchanim = false;
        magnification = false;
        mineffect = "scale";
        minimize-to-application = true;
        show-process-indicators = true;
        tilesize = 32;

        # Dont' rearrange spaces based on recent use
        mru-spaces = false;

        # Orientation of the dock
        orientation = "left";

        # Persistent apps/folders in the dock (empty by default and only shows currently open apps)
        persistent-apps = [];
        persistent-others = [];
        static-only = true;
        show-recents = false;
        showhidden = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        
        # Don't show files/folders on the desktop
        CreateDesktop = false;

        # Default search scope to the current folder
        FXDefaultSearchScope = "SCcf";

        # Open in list view by default
        FXPreferredViewStyle = "Nlsv";

        # Allow for using CMD + Q to exit finder
        QuitMenuItem = true;

        # Quality of life changes
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
    };
  };
}