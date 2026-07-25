{ config, pkgs, ... }:

{
  imports = [
    ./functions.nix
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
      echo
    '';
  };
}
