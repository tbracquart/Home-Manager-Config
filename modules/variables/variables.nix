{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Pour UWSM
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
