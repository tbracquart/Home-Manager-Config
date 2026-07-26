{ config, pkgs, lib, ... }:

{
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    # UWSM gère le cycle de vie de la session (voir modules/hyprland.nix côté
    # NixOS, programs.hyprland.withUWSM = true). Home Manager ne doit donc PAS
    # lancer son propre service systemd pour Hyprland.
    systemd.enable = false;

    settings = { };

    extraConfig = ''
      -- ============================================================
      --  CONFIGURATION PRINCIPALE (hl.config)
      -- ============================================================
      hl.config({
        general = {
          gaps_in = 5,
          gaps_out = 20,
          border_size = 2,
          ["col.active_border"] = "0xff33ccff",
          ["col.inactive_border"] = "0xff595959",
          layout = "dwindle"
        },
        decoration = {
          rounding = 15,
          rounding_power = 3,
          active_opacity = 0.90,
          inactive_opacity = 0.75,
          blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696
          },
          shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a
          }
        },
        input = {
          kb_layout = "fr",
          kb_variant = "latin9",
          follow_mouse = 1,
          touchpad = {
            natural_scroll = true,
            tap_to_click = true
          }
        }
      })

      -- ============================================================
      --  MONITEUR
      -- ============================================================
      hl.monitor({
        output = "eDP-1",
        mode = "1920x1080@60",
        position = "auto",
        scale = 1
      })

      -- ============================================================
      --  RÈGLES DE CALQUE (Noctalia) — flou barre/panneaux/dock/notifs
      -- ============================================================
      -- cf. https://docs.noctalia.dev/v5/compositor-settings/hyprland/
      -- (namespace v5, différent de la v4 : bar/notification/dock/panel/
      -- attached-panel/osd/window-switcher, tous préfixés "noctalia-").
      -- no_anim désactive les animations de calque natives de Hyprland
      -- pour ne pas interférer avec les animations propres de Noctalia.
      hl.layer_rule({
        name = "noctalia",
        match = {
          namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$"
        },
        no_anim = true,
        ignore_alpha = 0.5,
        blur = true,
        blur_popups = true
      })

      -- ============================================================
      --  WORKSPACES PERSISTANTS (recommandé par Noctalia)
      -- ============================================================
      -- Garde les workspaces vides visibles dans l'indicateur Noctalia
      -- au lieu de n'afficher que ceux qui contiennent des fenêtres.
      hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })

      -- ============================================================
      --  RACCOURCIS CLAVIER (hl.bind)
      -- ============================================================
      local mainMod = "SUPER"

      -- Lancements
      hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
      hl.bind(mainMod .. " + Q", hl.dsp.window.close())
      hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("firefox"))
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))

      -- Gestion des fenêtres
      hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
      hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))

      -- Changer de workspace
      hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
      hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
      hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
      hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
      hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
      hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
      hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
      hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
      hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
      hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

      hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
      hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
      hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
      hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
      hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))

      -- ============================================================
      --  RACCOURCIS IPC NOCTALIA (recommandés par la doc officielle v5)
      -- ============================================================
      -- cf. https://docs.noctalia.dev/v5/compositor-settings/hyprland/
      local ipc = "noctalia msg "

      hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
      hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
      hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
      hl.bind("ALT + TAB", hl.dsp.exec_cmd(ipc .. "window-switcher"))

      -- Touches multimédia
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

      -- ============================================================
      --  RACCOURCIS SOURIS
      -- ============================================================
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

      -- ============================================================
      --  RÈGLES DE FENÊTRES (hl.window_rule)
      -- ============================================================
      hl.window_rule({
        match = { class = "firefox", title = ".*Preferences.*" },
        float = true
      })
      hl.window_rule({
        match = { class = "org.keepassxc.KeePassXC" },
        float = true
      })
      hl.window_rule({
        match = { class = "discord" },
        workspace = 3
      })

      -- Fenêtre de réglages Noctalia : flottante, taille fixe (recommandé)
      hl.window_rule({
        match = { class = "dev.noctalia.Noctalia" },
        float = true,
        size = { 1080, 920 }
      })

      -- ============================================================
      --  LANCEMENT AU DÉMARRAGE (hl.on)
      -- ============================================================
      -- programs.noctalia.enable (module NixOS) installe le paquet et gère
      -- la config déclarative, mais NE lance PAS le shell tout seul.
      -- Le lancement via le compositeur est la méthode officiellement
      -- recommandée (le démarrage via service systemd est déprécié).
      -- ⚠️ Ne pas activer en même temps un service systemd Noctalia
      -- (programs.noctalia.systemd.enable) sous peine de double instance.
      hl.on("hyprland.start", function()
        hl.exec_cmd("noctalia")
      end)

      -- ============================================================
      --  ANIMATIONS
      -- ============================================================
      hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
      hl.curve("winIn", { type = "bezier", points = { {0.1, 1.1}, {0.1, 1.1} } })
      hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
      hl.curve("liner", { type = "bezier", points = { {1, 1}, {1, 1} } })

      hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "myBezier", style = "slide" })
      hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
      hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
      hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "myBezier", style = "slide" })
      hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
      hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
      hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
      hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "myBezier" })
    '';
  };
}
