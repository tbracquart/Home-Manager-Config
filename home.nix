{ config, pkgs, ... }:

{
  imports = [
#     <plasma-manager/modules>
    ./modules/default.nix
  ];

  home.username = "thibaut";
  home.homeDirectory = "/home/thibaut";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
