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
      --  Base = exemple officiel Hyprland (hyprwm/Hyprland, example/hyprland.lua)
      --  Toutes les valeurs esthétiques/comportementales (couleurs, rounding,
      --  opacity, blur, animations, touchpad) restent celles de l'officiel.
      --  Seuls les points indispensables (clavier AZERTY, écran, Noctalia,
      --  raccourcis d'applis perso) sont adaptés, marqués "-- [FR]" ou
      --  "-- [NOCTALIA]" ci-dessous.
      -- ============================================================

      ------------------
      ---- MONITORS ----
      ------------------

      -- See https://wiki.hypr.land/Configuring/Basics/Monitors/
      hl.monitor({
          output   = "eDP-1",
          mode     = "1920x1080@60.00300",
          position = "0x0",
          scale    = "1",
      })


      ---------------------
      ---- MY PROGRAMS ----
      ---------------------

      -- Set programs that you use
      local terminal    = "kitty"
      local fileManager = "dolphin"
      local menu        = "hyprlauncher" -- [FR] non utilisé actuellement : le launcher est géré par Noctalia (cf. RACCOURCIS IPC NOCTALIA)


      -------------------
      ---- AUTOSTART ----
      -------------------

      -- See https://wiki.hypr.land/Configuring/Basics/Autostart/

      -- Autostart necessary processes (like notifications daemons, status bars, etc.)
      -- Or execute your favorite apps at launch like this:
      --
      -- hl.on("hyprland.start", function ()
      --   hl.exec_cmd(terminal)
      --   hl.exec_cmd("nm-applet")
      --   hl.exec_cmd("waybar & hyprpaper & firefox")
      -- end)

      -- [NOCTALIA] Lancement du shell Noctalia au démarrage.
      -- programs.noctalia.enable (module NixOS) installe le paquet et gère
      -- la config déclarative, mais NE lance PAS le shell tout seul.
      -- Le lancement via le compositeur est la méthode officiellement
      -- recommandée (le démarrage via service systemd est déprécié).
      -- ⚠️ Ne pas activer en même temps un service systemd Noctalia
      -- (programs.noctalia.systemd.enable) sous peine de double instance.
      hl.on("hyprland.start", function()
        hl.exec_cmd("noctalia")
      end)


      -------------------------------
      ---- ENVIRONMENT VARIABLES ----
      -------------------------------

      -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

      hl.env("XCURSOR_SIZE", "24")
      hl.env("HYPRCURSOR_SIZE", "24")


      -----------------------
      ----- PERMISSIONS -----
      -----------------------

      -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
      -- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
      -- for security reasons

      -- hl.config({
      --   ecosystem = {
      --     enforce_permissions = true,
      --   },
      -- })

      -- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
      -- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
      -- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


      -----------------------
      ---- LOOK AND FEEL ----
      -----------------------

      -- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
      -- [FR] Toutes les valeurs ci-dessous sont celles de l'exemple officiel,
      -- inchangées (plus de couleurs/rounding/opacity/blur perso).
      hl.config({
          general = {
              gaps_in  = 5,
              gaps_out = 20,

              border_size = 2,

              col = {
                  active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
                  inactive_border = "rgba(595959aa)",
              },

              -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
              resize_on_border = false,

              -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
              allow_tearing = false,

              layout = "dwindle",
          },

          decoration = {
              rounding       = 10,
              rounding_power = 2,

              -- Change transparency of focused and unfocused windows
              active_opacity   = 1.0,
              inactive_opacity = 1.0,

              shadow = {
                  enabled      = true,
                  range        = 4,
                  render_power = 3,
                  color        = 0xee1a1a1a,
              },

              blur = {
                  enabled   = true,
                  size      = 3,
                  passes    = 1,
                  vibrancy  = 0.1696,
              },
          },

          animations = {
              enabled = true,
          },
      })

      -- Animations Caelestia (https://github.com/caelestia-dots/caelestia/blob/main/hypr/hyprland/animations.lua)
      -- au lieu des courbes/animations par défaut de l'exemple officiel Hyprland.
      hl.curve("specialWorkSwitch", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
      hl.curve("emphasizedAccel",   { type = "bezier", points = { { 0.3, 0 },    { 0.8, 0.15 } } })
      hl.curve("emphasizedDecel",   { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
      hl.curve("standard",          { type = "bezier", points = { { 0.2, 0 },    { 0, 1 } } })

      hl.animation({ leaf = "layersIn",  enabled = true, speed = 5, bezier = "emphasizedDecel", style = "slide" })
      hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "emphasizedAccel", style = "slide" })
      hl.animation({ leaf = "fadeLayers", enabled = true, speed = 5, bezier = "standard" })

      hl.animation({ leaf = "windowsIn",   enabled = true, speed = 5, bezier = "emphasizedDecel" })
      hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "emphasizedAccel" })
      hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "standard" })
      hl.animation({ leaf = "workspaces",  enabled = true, speed = 5, bezier = "standard" })

      hl.animation({
          leaf    = "specialWorkspace",
          enabled = true,
          speed   = 4,
          bezier  = "specialWorkSwitch",
          style   = "slidefadevert 15%"
      })
      hl.animation({ leaf = "fade",    enabled = true, speed = 6, bezier = "standard" })
      hl.animation({ leaf = "fadeDim", enabled = true, speed = 6, bezier = "standard" })
      hl.animation({ leaf = "border",  enabled = true, speed = 6, bezier = "standard" })

      -- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
      -- "Smart gaps" / "No gaps when only"
      -- uncomment all if you wish to use that.
      -- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
      -- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
      -- hl.window_rule({
      --     name  = "no-gaps-wtv1",
      --     match = { float = false, workspace = "w[tv1]" },
      --     border_size = 0,
      --     rounding    = 0,
      -- })
      -- hl.window_rule({
      --     name  = "no-gaps-f1",
      --     match = { float = false, workspace = "f[1]" },
      --     border_size = 0,
      --     rounding    = 0,
      -- })

      -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
      hl.config({
          dwindle = {
              preserve_split = true, -- You probably want this
          },
      })

      -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
      hl.config({
          master = {
              new_status = "master",
          },
      })

      -- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
      hl.config({
          scrolling = {
              fullscreen_on_one_column = true,
          },
      })

      ----------------
      ----  MISC  ----
      ----------------

      hl.config({
          misc = {
              force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
              disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
          },
      })


      ---------------
      ---- INPUT ----
      ---------------

      hl.config({
          input = {
              kb_layout  = "fr",     -- [FR] clavier AZERTY au lieu de "us"
              kb_variant = "latin9", -- [FR] variante latin9 au lieu de ""
              kb_model   = "",
              kb_options = "",
              kb_rules   = "",

              follow_mouse = 1,

              sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

              touchpad = {
                  natural_scroll = false,
              },
          },
      })

      hl.gesture({
          fingers = 3,
          direction = "horizontal",
          action = "workspace"
      })

      -- Example per-device config
      -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
      hl.device({
          name        = "epic-mouse-v1",
          sensitivity = -0.5,
      })


      ---------------------
      ---- KEYBINDINGS ----
      ---------------------

      local mainMod = "SUPER" -- Sets "Windows" key as main modifier

      -- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
      -- hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
      local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
      -- closeWindowBind:set_enabled(false)
      hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
      hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
      hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
      hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

      -- [FR] Raccourcis d'applis perso, en plus des binds officiels ci-dessus
      -- (gardés volontairement malgré le doublon fonctionnel avec Super+Q/E).
      hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
      hl.bind(mainMod .. " + O",      hl.dsp.exec_cmd("firefox"))
      hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen({ action = "toggle" }))
      hl.bind(mainMod .. " + SHIFT + F",   hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

      -- Move focus with mainMod + arrow keys
      hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
      hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
      hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
      hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

      -- Switch workspaces with mainMod + [0-9]
      -- Move active window to a workspace with mainMod + SHIFT + [0-9]
      -- [FR] mapping AZERTY (rangée de chiffres sans Shift) au lieu du
      -- mapping officiel mainMod + [0-9] (qui suppose un clavier US/QWERTY).
      local keys = { "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave" }

      for i, key in ipairs(keys) do
          hl.bind("SUPER + " .. key,         hl.dsp.focus({ workspace = i }))
          hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      -- Example special workspace (scratchpad)
      -- [FR] déplacé de Super+S vers Super+G : Super+S est pris par Noctalia
      -- (panel-toggle control-center, voir RACCOURCIS IPC NOCTALIA plus bas).
      hl.bind(mainMod .. " + G",         hl.dsp.workspace.toggle_special("magic"))
      hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "special:magic" }))

      -- Scroll through existing workspaces with mainMod + scroll
      hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

      -- Move/resize windows with mainMod + LMB/RMB and dragging
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- ============================================================
      --  RACCOURCIS IPC NOCTALIA (recommandés par la doc officielle v5)
      -- ============================================================
      -- cf. https://docs.noctalia.dev/v5/compositor-settings/hyprland/
      local ipc = "noctalia msg "

      hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
      hl.bind(mainMod .. " + S",     hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
      hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
      hl.bind("ALT + TAB",           hl.dsp.exec_cmd(ipc .. "window-switcher"))

      -- [NOCTALIA] Touches multimédia via l'IPC Noctalia (OSD visuel cohérent)
      -- au lieu de wpctl/brightnessctl direct.
      hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(ipc .. "volume-up"))
      hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(ipc .. "volume-down"))
      hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(ipc .. "volume-mute"))
      hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(ipc .. "brightness-up"))
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

      -- Requires playerctl (officiel, gardé tel quel : pas de conflit avec Noctalia)
      hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


      --------------------------------
      ---- WINDOWS AND WORKSPACES ----
      --------------------------------

      -- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
      -- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

      -- [FR] Workspaces persistants (recommandé par Noctalia) : garde les
      -- workspaces vides visibles dans l'indicateur Noctalia au lieu de
      -- n'afficher que ceux qui contiennent des fenêtres.
      hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
      hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })

      -- Example window rules that are useful

      local suppressMaximizeRule = hl.window_rule({
          -- Ignore maximize requests from all apps. You'll probably like this.
          name  = "suppress-maximize-events",
          match = { class = ".*" },

          suppress_event = "maximize",
      })
      -- suppressMaximizeRule:set_enabled(false)

      hl.window_rule({
          -- Fix some dragging issues with XWayland
          name  = "fix-xwayland-drags",
          match = {
              class      = "^$",
              title      = "^$",
              xwayland   = true,
              float      = true,
              fullscreen = false,
              pin        = false,
          },

          no_focus = true,
      })

      -- Hyprland-run windowrule
      hl.window_rule({
          name  = "move-hyprland-run",
          match = { class = "hyprland-run" },

          move  = "20 monitor_h-120",
          float = true,
      })

      -- [FR] Règles de fenêtres perso
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

      -- [NOCTALIA] Fenêtre de réglages Noctalia : flottante, taille fixe (recommandé)
      hl.window_rule({
          match = { class = "dev.noctalia.Noctalia" },
          float = true,
          size = { 1080, 920 }
      })

      -- ============================================================
      -- [NOCTALIA] RÈGLES DE CALQUE — flou barre/panneaux/dock/notifs
      -- ============================================================
      -- cf. https://docs.noctalia.dev/v5/compositor-settings/hyprland/
      -- (namespace v5, différent de la v4 : bar/notification/dock/panel/
      -- attached-panel/osd/window-switcher, tous préfixés "noctalia-").
      -- no_anim désactive les animations de calque natives de Hyprland
      -- pour ne pas interférer avec les animations propres de Noctalia.
      -- ⏸️ Toujours en attente de décision : à décommenter une fois le
      -- comportement de blur validé.
      -- local noctaliaLayerRule = hl.layer_rule({
      --     name = "noctalia",
      --     match = {
      --         namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$"
      --     },
      --     no_anim = true,
      --     ignore_alpha = 0.5,
      --     blur = true,
      --     blur_popups = true
      -- })
      -- noctaliaLayerRule:set_enabled(false)

      -- Layer rules also return a handle.
      -- local overlayLayerRule = hl.layer_rule({
      --     name  = "no-anim-overlay",
      --     match = { namespace = "^my-overlay$" },
      --     no_anim = true,
      -- })
      -- overlayLayerRule:set_enabled(false)
    '';
  };
}
