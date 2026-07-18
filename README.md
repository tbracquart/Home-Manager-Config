# Home Manager Config

> 🇫🇷 Version française — [🇬🇧 English version here](./README.en.md)

Ma configuration [Home Manager](https://github.com/nix-community/home-manager), séparée de ma configuration système NixOS.

Ce dépôt gère tout ce qui est propre à **mon compte utilisateur** : packages personnels, dotfiles, configuration d'applications. Il est volontairement indépendant de la configuration système pour rester propre au niveau des permissions : la config système appartient à `root`, celle-ci m'appartient.

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
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Puis remplacer le fichier généré par celui de ce dépôt :

```bash
git clone https://github.com/tbracquart/Home-Manager-Config ~/Home-Manager-Config
rm ~/.config/home-manager/home.nix
ln -s ~/Home-Manager-Config/home.nix ~/.config/home-manager/home.nix
home-manager switch
```

---

## Note

Ce dépôt est encore minimal — il évoluera au fur et à mesure que j'y ajoute des dotfiles et des configurations d'applications.
