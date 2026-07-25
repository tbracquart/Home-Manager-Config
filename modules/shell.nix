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
