{ config, pkgs, ... }:

{
  imports = [
    <plasma-manager/modules>  # ✅ Chemin correct
    ./modules/plasma.nix
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/programs.nix
    ./modules/hyprland.nix
    ./modules/services.nix
    ./modules/variables.nix
  ];

  # Options globales
  home.username = "thibaut";
  home.homeDirectory = "/home/thibaut";
  home.stateVersion = "26.05";

  # Activation de home-manager lui-même
  programs.home-manager.enable = true;

  # Fichiers de configuration (dotfiles)
  # Laissez vide ou ajoutez des fichiers si besoin
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
}
