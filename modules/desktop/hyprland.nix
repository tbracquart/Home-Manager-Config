{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
    configType = "lua";

    settings = {
      "$mod" = "SUPER";
      monitor = ",preferred,auto,auto";

      bind = [
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, E, exec, dolphin"
      ] ++ builtins.concatLists (builtins.genList (i:
        let ws = i + 1; in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9);
    };

    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("waybar")
      end)
    '';
  };
}
