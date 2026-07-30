{ pkgs, ... }:

let
  freesmlauncherSrc = builtins.fetchTarball {
    url = "https://github.com/FreesmTeam/FreesmLauncher/archive/refs/heads/develop.tar.gz";
    # pas de sha256 = Nix retélécharge et revérifie à CHAQUE rebuild
  };

  flakeCompat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  };

  freesmlauncherFlake = (import "${flakeCompat}" { src = freesmlauncherSrc; }).defaultNix;

in {
  home.packages = [
    freesmlauncherFlake.packages.${pkgs.system}.default
  ];
}
