{ config, pkgs, ... }:

{
  imports = [
    <plasma-manager/modules>
    ./modules/desktop/default.nix
    ./modules/files/default.nix
    ./modules/packages/default.nix
    ./modules/programs/default.nix
    ./modules/services/default.nix
    ./modules/shell/default.nix
    ./modules/variables/default.nix
  ];

  # Options globales
  home.username = "thibaut";
  home.homeDirectory = "/home/thibaut";
  home.stateVersion = "26.05";

  # Activation de home-manager lui-même
  programs.home-manager.enable = true;
}
