{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "Thibaut Bracquart";
    settings.user.email = "202062783+tbracquart@users.noreply.github.com";
  };
}
