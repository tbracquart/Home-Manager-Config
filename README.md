J'ai regardé le README sur ton GitHub. Tu as raison, il ne reflète plus du tout l'état actuel de ta configuration. Voici une proposition de mise à jour qui colle à la structure modulaire qu'on a construite ensemble.

---

## Proposition de nouveau README.md

```markdown
# Home Manager Config

Ma configuration [Home Manager](https://github.com/nix-community/home-manager), séparée de ma configuration système NixOS.

Ce dépôt gère tout ce qui est propre à **mon compte utilisateur** : packages personnels, dotfiles, configuration d'applications. Il est volontairement indépendant de la configuration système pour rester propre au niveau des permissions : la config système appartient à `root`, celle-ci m'appartient.

---

## Structure du dépôt

```
.
├── home.nix                     # Point d'entrée principal
└── modules/
    ├── apps/
    │   ├── default.nix          # Importe les fichiers apps
    │   ├── packages.nix         # Paquets sans configuration spécifique
    │   └── git.nix              # Git (installation + configuration)
    ├── desktop/
    │   ├── default.nix          # Importe les fichiers desktop
    │   ├── hyprland.nix         # Configuration Hyprland
    │   └── plasma.nix           # Thème et look-and-feel Plasma
    ├── files/
    │   ├── default.nix          # Importe files.nix
    │   └── files.nix            # Gestion des dotfiles (home.file)
    ├── services/
    │   ├── default.nix          # Importe les fichiers services
    │   └── kdeconnect.nix       # Service KDE Connect
    ├── shell/
    │   ├── default.nix          # Importe les fichiers shell
    │   ├── fish.nix             # Configuration de base de Fish
    │   └── functions.nix        # Fonctions personnalisées Fish
    ├── variables/
    │   ├── default.nix          # Importe variables.nix
    │   └── variables.nix        # Variables d'environnement
    └── default.nix              # Point d'entrée unique des modules
```

Chaque dossier possède un `default.nix` qui importe l'ensemble de ses fichiers, rendant la configuration modulaire et facile à maintenir.

---

## Lien avec ma config système

Ce repo fonctionne en complément de **[NixOS-Config](https://github.com/tbracquart/NixOS-Config)**, qui gère la partie système (boot, matériel, services, comptes utilisateurs).

Home Manager tourne ici en mode **standalone** : deux commandes séparées, une pour chaque niveau.

| Commande | Ce qu'elle reconstruit |
|---|---|
| `sudo nixos-rebuild switch` | Le système (dans `NixOS-Config`) |
| `home-manager switch` | Mon environnement utilisateur (ce dépôt) |

---

## Installation sur une nouvelle machine

```bash
# Ajouter le canal Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update

# Installer Home Manager
nix-shell '<home-manager>' -A install

# Cloner et utiliser cette configuration
git clone https://github.com/tbracquart/Home-Manager-Config ~/Home-Manager-Config
rm ~/.config/home-manager/home.nix
ln -s ~/Home-Manager-Config/home.nix ~/.config/home-manager/home.nix

# Appliquer la configuration
home-manager switch
```

---

## Commandes Fish personnalisées

Ce dépôt ajoute plusieurs fonctions utiles à mon shell Fish :

- `clr` : efface l'écran et affiche fastfetch
- `push [-s|--system] [-u|--user]` : push les modifications Git pour NixOS ou Home Manager
- `update [-s|--system] [-u|--user]` : met à jour les canaux Nix
- `rebuild [-s|--system] [-u|--user]` : reconstruit le système ou l'environnement utilisateur
- `upgrade [-s|--system] [-u|--user]` : combine `update` et `rebuild`

Sans option, ces commandes agissent à la fois sur le système et l'utilisateur.

---

## Note

Ce dépôt est encore en évolution — il s'enrichit au fur et à mesure que j'ajoute des dotfiles et des configurations d'applications.
```

---

## Ce qui a changé dans le README

| Point | Avant | Après |
|-------|-------|-------|
| **Structure** | Non documentée | Arborescence complète des `modules/` |
| **Organisation** | Non expliquée | Chaque dossier est décrit |
| **Commandes Fish** | Absentes | Listées avec leurs options |
| **Installation** | `mv` | `ln -s` (plus propre) |
| **Version** | "encore minimal" | "encore en évolution" |

---

## 🔧 Action

```fish
# Remplacer le README
cat > README.md << 'EOF'
[... contenu ci-dessus ...]
EOF

# Commit
git add README.md
git commit -m "docs: update README to reflect current modular structure"
git push
```

---

**Le README est maintenant à jour et documente toute ta structure modulaire.** 👍
