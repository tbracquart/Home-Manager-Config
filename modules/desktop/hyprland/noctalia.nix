{ config, pkgs, ... }:

let
  noctalia-src = fetchTarball "https://github.com/noctalia-dev/noctalia/archive/main.tar.gz";
  noctalia = import noctalia-src { inherit pkgs; };

  wallpaperDir = "${config.home.homeDirectory}/Images/Fonds d'écran";
  wallpaperFile = "wp12329556-nixos-wallpapers.png";
  wallpaperPath = "${wallpaperDir}/${wallpaperFile}";
in
{
  imports = [ noctalia.homeModule ];

{
  audio = {
    enable_sounds = true;
  };

  bar = {
    default = {
      capsule = true;
      center = [ "group:g4" ];
      end = [ "tray" "group:g3" ];
      margin_ends = 50;
      start = [ "group:g2" ];
      capsule_group = [
        {
          enabled = true;
          fill = "surface_variant";
          id = "g1";
          members = [ "network" "bluetooth" "volume" "battery" ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          enabled = true;
          fill = "surface_variant";
          id = "g2";
          members = [ "launcher" "wallpaper" "workspaces" ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          enabled = true;
          fill = "surface_variant";
          id = "g3";
          members = [ "network" "bluetooth" "volume" "battery" "session" ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          enabled = true;
          fill = "surface_variant";
          id = "g4";
          members = [ "control-center" "clock" "media" "notifications" "clipboard" ];
          opacity = 1.0;
          padding = 6.0;
        }
      ];
    };
  };

  battery = {
    warning_threshold = 20;
  };

  calendar = {
    enabled = true;
    account = {
      personal_google = {
        name = "Thibaut";
        type = "google";
      };
    };
  };

  desktop_widgets = {
    schema_version = 2;
    widget_order = [
      "desktop-widget-0000000000000002"
      "desktop-widget-0000000000000003"
      "desktop-widget-0000000000000004"
      "desktop-widget-0000000000000005"
    ];
    grid = {
      cell_size = 16;
      major_interval = 4;
      visible = true;
    };
    widget = {
      "desktop-widget-0000000000000002" = {
        box_height = 144.0;
        box_width = 336.0;
        cx = 210.0;
        cy = 952.0;
        output = "eDP-1";
        rotation = 0.0;
        type = "media_player";
      };
      "desktop-widget-0000000000000003" = {
        box_height = 96.0;
        box_width = 240.0;
        cx = 424.0;
        cy = 124.0;
        output = "eDP-1";
        rotation = 0.0;
        type = "weather";
      };
      "desktop-widget-0000000000000004" = {
        box_height = 96.0;
        box_width = 192.0;
        cx = 144.0;
        cy = 124.0;
        output = "eDP-1";
        rotation = 0.0;
        type = "clock";
      };
      "desktop-widget-0000000000000005" = {
        box_height = 144.0;
        box_width = 224.0;
        cx = 512.0;
        cy = 952.0;
        output = "eDP-1";
        rotation = 0.0;
        type = "sysmon";
        settings = {
          stat = "cpu_usage";
          stat2 = "cpu_temp";
        };
      };
    };
  };

  dock = {
    active_monitor_only = true;
    enabled = true;
    launcher_position = "start";
    pinned = [ "firefox" "org.kde.dolphin" "kitty" ];
    reserve_space = false;
    show_dots = true;
    smart_auto_hide = true;
  };

  location = {
    auto_locate = true;
  };

  lockscreen_widgets = {
    enabled = true;
    schema_version = 2;
    widget_order = [ "lockscreen-login-box@eDP-1" ];
    grid = {
      cell_size = 16;
      major_interval = 4;
      visible = true;
    };
    widget = {
      "lockscreen-login-box@eDP-1" = {
        box_height = 213.0;
        box_width = 810.0;
        cx = 960.0;
        cy = 889.5;
        output = "eDP-1";
        rotation = 0.0;
        type = "login_box";
        settings = {
          background_color = "surface_variant";
          background_opacity = 0.88;
          background_radius = 12.0;
          center_password_text = false;
          input_opacity = 1.0;
          input_radius = 6.0;
          layout = "regular";
          show_caps_lock = true;
          show_keyboard_layout = true;
          show_login_button = true;
          show_password_hint = true;
          show_session_buttons = true;
        };
      };
    };
  };

  shell = {
    corner_radius_scale = 2.0;
    polkit_agent = true;
    panel = {
      clipboard_placement = "attached";
      launcher_placement = "attached";
      transparency_mode = "glass";
    };
    screen_corners = {
      enabled = true;
    };
  };

  theme = {
    builtin = "Noctalia";
    community_palette = "Oxocarbon";
    mode = "auto";
    source = "wallpaper";
    wallpaper_scheme = "vibrant";
  };

  wallpaper = {
    directory = wallpaperDir;
    default = {
      path = wallpaperPath;
    };
    last = {
      path = wallpaperPath;
    };
    monitors = {
      "eDP-1" = {
        path = wallpaperPath;
      };
    };
  };

  widget = {
    battery = {
      hide_when_full = true;
      show_label = false;
    };
    brightness = {
      show_label = false;
    };
    media = {
      hide_when_no_media = true;
    };
    network = {
      show_label = false;
    };
    notifications = {
      hide_when_no_unread = true;
    };
    volume = {
      show_label = false;
    };
    wallpaper = {
      enabled = false;
    };
    workspaces = {
      capsule_radius = "auto";
    };
  };
}
