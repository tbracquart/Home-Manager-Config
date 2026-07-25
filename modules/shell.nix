{ config, pkgs, ... }:

{
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

      # ANCIENNES FONCTIONS SUPPRIMÉES :
      # nixpush = ...
      # hmpush = ...

      push = ''
        switch $argv[1]
          case -s --system
            cd /etc/nixos
            sudo git add .
            sudo git status
            read -l -P "Message de commit : " commit_msg
            sudo git commit -m "$commit_msg"
            sudo git push
          case -u --user
            cd ~/.config/home-manager
            git add .
            git status
            read -l -P "Message de commit : " commit_msg
            git commit -m "$commit_msg"
            git push
          case ""
            echo "📦 Push système..."
            cd /etc/nixos
            sudo git add .
            sudo git status
            read -l -P "Message de commit : " commit_msg
            sudo git commit -m "$commit_msg"
            sudo git push
            and echo
            and echo "📦 Push utilisateur..."
            and cd ~/.config/home-manager
            and git add .
            and git status
            and read -l -P "Message de commit : " commit_msg
            and git commit -m "$commit_msg"
            and git push
          case '*'
            echo "❌ Utilisation: push [-s|--system] [-u|--user]"
            return 1
        end
        echo "✅ Push terminé !"
      '';

      update = ''
        switch $argv[1]
          case -s --system
            echo "🔄 Mise à jour du canal système..."
            sudo nix-channel --update
          case -u --user
            echo "🔄 Mise à jour du canal utilisateur..."
            nix-channel --update
          case ""
            echo "🔄 [1/2] Mise à jour du canal système..."
            sudo nix-channel --update
            and echo
            and echo "🔄 [2/2] Mise à jour du canal utilisateur..."
            and nix-channel --update
          case '*'
            echo "❌ Utilisation: update [-s|--system] [-u|--user]"
            return 1
        end
        echo "✅ Canaux à jour !"
      '';

      rebuild = ''
        switch $argv[1]
          case -s --system
            echo "🚀 Reconstruction du système NixOS..."
            sudo nixos-rebuild switch
          case -u --user
            echo "🚀 Application de la configuration Home Manager..."
            home-manager switch
          case ""
            echo "🚀 [1/2] Reconstruction du système NixOS..."
            sudo nixos-rebuild switch
            and echo
            and echo "🚀 [2/2] Application de la configuration Home Manager..."
            and home-manager switch
          case '*'
            echo "❌ Utilisation: rebuild [-s|--system] [-u|--user]"
            return 1
        end
        echo "✅ Fini !"
      '';

      upgrade = ''
        switch $argv[1]
          case -s --system
            echo "🌟 Mise à jour système uniquement 🌟"
            update --system
            and echo
            and rebuild --system
          case -u --user
            echo "🌟 Mise à jour utilisateur uniquement 🌟"
            update --user
            and echo
            and rebuild --user
          case ""
            echo "🌟 Mise à jour complète (système + utilisateur) 🌟"
            update
            and echo
            and rebuild
          case '*'
            echo "❌ Utilisation: upgrade [-s|--system] [-u|--user]"
            return 1
        end
        echo "🎉 Terminé !"
      '';
    };
  };
}
