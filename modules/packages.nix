{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.kdeconnect-kde
    netflix
    ytmdesktop
    klavaro
  ];
}
