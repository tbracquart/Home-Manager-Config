# Home-Manager-Config/modules/desktop/hyprland.nix
{ config, pkgs, lib, ... }:

let
  lua = lib.generators.mkLuaInline;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua"; # 👈 FORCER LE FORMAT LUA
    systemd.enable = false;

    settings = {
      # ---- VARIABLES GLOBALES ----
      mod = { _var = "SUPER"; };

      # ---- GENERAL ----
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg"; # Exemple
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      # ---- DECORATIONS ----
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 4;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      # ---- ANIMATIONS ----
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # ---- RACCOURCIS CLAVIER ----
      bind = [
        # Lancements
        {
          _args = [
            "SUPER + RETURN"
            (lua "hl.exec_cmd('kitty')")
          ];
        }
        {
          _args = [
            "SUPER + D"
            (lua "hl.exec_cmd('wofi --show drun')")
          ];
        }
        {
          _args = [
            "SUPER + Q"
            (lua "hl.exec_cmd('kill')")
          ];
        }
        # Gestion des fenêtres
        {
          _args = [
            "SUPER + F"
            (lua "hl.dsp.window.set_fullscreen('toggle')")
          ];
        }
        {
          _args = [
            "SUPER + SPACE"
            (lua "hl.dsp.layout.toggle_floating()")
          ];
        }
        # Workspaces
        {
          _args = [
            "SUPER + 1"
            (lua "hl.dsp.workspace.switch(1)")
          ];
        }
        {
          _args = [
            "SUPER + 2"
            (lua "hl.dsp.workspace.switch(2)")
          ];
        }
        # ... ajoute tous tes raccourcis
      ];

      # ---- BINDES AVEC MODIFICATEURS ----
      bindm = [
        {
          _args = [
            "SUPER + mouse:272"
            (lua "hl.dsp.window.move()")
          ];
        }
        {
          _args = [
            "SUPER + mouse:273"
            (lua "hl.dsp.window.resize()")
          ];
        }
      ];

      # ---- REGLES DE FENETRES ----
      window_rule = [
        # Flotter certaines fenêtres
        {
          _args = [
            (lua "hl.dsp.window.match({ class = 'firefox', title = '.*Preferences.*' })")
            { floating = true; }
          ];
        }
        {
          _args = [
            (lua "hl.dsp.window.match({ class = 'org.keepassxc.KeePassXC' })")
            { floating = true; }
          ];
        }
        # Envoyer sur un workspace spécifique
        {
          _args = [
            (lua "hl.dsp.window.match({ class = 'discord' })")
            { workspace = 3; }
          ];
        }
        {
          _args = [
            (lua "hl.dsp.window.match({ class = 'steam_app_\\d+' })")
            { fullscreen = "on"; }
          ];
        }
      ];

      # ---- LANCEMENT AU DEMARRAGE ----
      on = [
        # Noctalia V5
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd("noctalia")
              end
            '')
          ];
        }
        # Fond d'écran (si tu utilises hyprpaper)
        {
          _args = [
            "hyprland.start"
            (lua "hl.exec_cmd('hyprpaper')")
          ];
        }
        # Barre (ex: waybar)
        {
          _args = [
            "hyprland.start"
            (lua "hl.exec_cmd('waybar')")
          ];
        }
      ];

      # ---- AUTRES OPTIONS ----
      input = {
        kb_layout = "fr";
        kb_variant = "latin9";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      # Gestion de l'écran
      monitor = [
        {
          _args = [
            "eDP-1"
            (lua "hl.dsp.monitor.set('1920x1080@60', 'auto', 1)")
          ];
        }
      ];
    };
  };
}
