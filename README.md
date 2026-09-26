# dotfiles

Hyprland/Omarchy, LazyVim, foot, git, btop, lazygit, starship — tracked with
[chezmoi](https://chezmoi.io).

## Restore onto a new machine

```bash
chezmoi init --apply https://github.com/kliewerdaniel/dotfiles
```

Then install the binaries this config expects:

```bash
sudo pacman -S --needed foot wl-clipboard ripgrep bat eza jq fd lazygit
mise use -g chezmoi
```

## Layout

Only a curated set is managed. `~/.config` is deliberately **not** added
wholesale, because it contains `gh` (an oauth token), browser profiles, and
machine-specific app state. `.chezmoiignore` guards against a future blanket
`chezmoi add ~/.config`.

| Path | Notes |
|---|---|
| `.config/hypr/` | keybindings, monitors, autostart, look-and-feel |
| `.config/nvim/` | LazyVim, `lazy-lock.json` pinned (51 plugins) |
| `.config/foot/` | terminal |
| `.config/omarchy/shell.json` | bar + idle |
| `.config/git/config` | aliases, `rerere`, histogram diff |
| `.config/lazygit`, `btop`, `starship.toml` | |
| `.bashrc` | |

## Machine-specific, do not "fix" blindly

This is a 2017 MacBookPro13,3 (i7-6820HQ) with an RX 460.

- **RX 460 (amdgpu, card1) owns the internal eDP panel.** Intel HD 530 (i915,
  card0) has every connector disconnected and zero CRTCs. Disabling amdgpu or
  setting `amdgpu.modeset=0` removes the *only* working display. Advice to
  "disable the dGPU to fix a black screen" is inverted on this hardware.
- 15 GB RAM, no viable GPU offload for 8B models; local llama.cpp runs CPU-only
  with `-t 8 -tb 8 -np 1 -ngl 0`.
- Boot is Limine, not GRUB. Kernel cmdline lives in `/etc/default/limine` and
  `/etc/limine-entry-tool.d/*.conf`, not `/etc/kernel/cmdline`, and must be
  rebuilt with `sudo limine-mkinitcpio`.

## Everyday use

```bash
chezmoi diff            # what changed on this machine
chezmoi apply           # push machine state into the repo
chezmoi update          # pull, then apply
cd ~/.local/share/chezmoi && git push
```
