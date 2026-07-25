{ config, pkgs, lib, ... }:

let
  # Définir des helpers pour le Lua
  lua = lib.generators.mkLuaInline;
  bind = key: action: {
    _args = [
      key
      (lua action)
    ];
  };
  exec = cmd: "hl.dsp.exec_cmd(\"${cmd}\")";
in {
  wayland.windowManager.hyprland = {
    enable = true;

    # Optionnel : Spécifier une version particulière depuis nixpkgs-unstable
    # package = pkgs.hyprland;
  };

  # La configuration Lua se fait via `settings`
  wayland.windowManager.hyprland.settings = {
    # Variables Lua
    mod = {
      _var = "SUPER";
    };

    # Configuration principale
    config = {
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        # ... tes réglages
      };
    };

    # Raccourcis clavier (exemple)
    bind = [
      (bind "SUPER + RETURN" (exec "kitty"))
      (bind "SUPER + D" (exec "wofi"))
      (bind "SUPER + SHIFT + S" (exec "hyprshot -m region -z --clipboard only"))
    ];
  };
}
