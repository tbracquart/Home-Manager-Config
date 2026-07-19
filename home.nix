{ config, pkgs, ... }:

{
  home.username = "thibaut";
  home.homeDirectory = "/home/thibaut";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/thibaut/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = "Thibaut Bracquart";
    settings.user.email = "202062783+tbracquart@users.noreply.github.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
      echo
    '';

    functions = {
      clr = ''
        clear
        fastfetch
        echo
      '';

      nixpush = ''
        cd /etc/nixos
        sudo git add .
        sudo git status
        read -l -P "Message de commit : " commit_msg
        sudo git commit -m "$commit_msg"
        sudo git push
      '';

      hmpush = ''
        cd ~/.config/home-manager
        git add .
        git status
        read -l -P "Message de commit : " commit_msg
        git commit -m "$commit_msg"
        git push
      '';

      update = ''
        echo "🔄 [1/2] Mise à jour du canal système (root)..."
        sudo nix-channel --update
        and echo
        and echo "🔄 [2/2] Mise à jour du canal utilisateur..."
        and nix-channel --update
        and echo
        and echo "✅ Tous les canaux sont à jour !"
      '';

      rebuild = ''
        echo "🚀 [1/2] Reconstruction du système NixOS..."
        sudo nixos-rebuild switch
        and echo
        and echo "🚀 [2/2] Application de la configuration Home Manager..."
        and home-manager switch
        and echo
        and echo "✅ Configurations appliquées avec succès !"
      '';

      upgrade = ''
        echo "🌟 Début de la mise à jour globale de NixOS et Home Manager 🌟"
        update
        and echo
        and rebuild
        and echo
        and echo "🎉 Votre système est parfaitement à jour !"
      '';
    };
  };
}
