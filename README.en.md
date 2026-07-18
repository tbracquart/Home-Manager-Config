# Home Manager Config

> 🇬🇧 English version — [🇫🇷 Version française ici](./README.md)

My [Home Manager](https://github.com/nix-community/home-manager) configuration, kept separate from my NixOS system configuration.

This repo manages everything specific to **my user account**: personal packages, dotfiles, application configuration. It's intentionally independent from the system configuration to keep permissions clean: the system config is owned by `root`, this one is owned by me.

---

## Link with my system config

This repo works alongside **[NixOS-Config](https://github.com/tbracquart/NixOS-Config)**, which handles the system side (boot, hardware, services, user accounts).

Home Manager runs here in **standalone** mode: two separate commands, one for each layer.

| Command | What it rebuilds |
|---|---|
| `sudo nixos-rebuild switch` | The system (in `NixOS-Config`) |
| `home-manager switch` | My user environment (this repo) |

---

## Setup on a new machine

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Then replace the generated file with the one from this repo:

```bash
git clone https://github.com/tbracquart/Home-Manager-Config ~/Home-Manager-Config
rm ~/.config/home-manager/home.nix
ln -s ~/Home-Manager-Config/home.nix ~/.config/home-manager/home.nix
home-manager switch
```

---

## Note

This repo is still minimal — it will grow as I add dotfiles and application configs over time.
