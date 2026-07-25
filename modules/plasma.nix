{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "Utterly-Sweet";
      colorScheme = "UtterlySweet";
    };

    icons.theme = "BeautySolar";
    widgets.style = "Breeze";
  };
}
