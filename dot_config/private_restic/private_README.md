# restic backup

Nightly backup of `/home/daniel`.

| | |
|---|---|
| Tool | `restic` 0.19.1 |
| Repo | `/home/daniel/.restic-repo` (internal NVMe) |
| Config | `~/.config/restic/config` |
| Password | `~/.config/restic/password` (chmod 600, **never** in git) |
| Schedule | `restic-backup.timer` — nightly 04:17–04:47, `Persistent=true` |
| Retention | 4×daily, 7×daily, 4×weekly, 6×monthly, 3×yearly |

## ⚠️ Read this before trusting it

**The repository is on the same disk it is backing up.**

That protects you from:
- `rm -rf` of a config directory
- a bad edit that destroys state
- malware / ransomware

It does **not** protect you from:
- NVMe failure or corruption
- fire, theft, or a dead machine
- anything that takes the whole filesystem

For those you need an off-machine copy. Nothing else in this setup is
a substitute. To add one (pick exactly one, then re-init or add a second repo):

```bash
# Option A: a USB drive. Mount it, then:
sudo mkdir -p /mnt/backup
sudo mount /dev/sdX2 /mnt/backup
sudo chown daniel:daniel /mnt/backup
cp -a ~/.restic-repo /mnt/backup/restic-repo   # or restic copy

# Option B: a second machine over SSH (needs sshd there)
#   restic -r sftp:user@host:/path/to/repo ...
# Option C: cloud via rest-server / rclone (needs an install + config)
```

Until then, treat this as *undo for mistakes*, not a backup.

## Excluded, on purpose

| Path | Why |
|---|---|
| `~/models` | 11 GB of GGUF weights, redownloadable |
| `~/.cache` | rebuildable |
| `~/.restic-repo` | the repo itself — including it is recursive bloat |
| `~/.local/state/omarchy/toggles` | transient UI state |
| `**/.Trash-*`, `**/trash/**` | trash |

## Not covered

`/etc`, `/boot`, `/var`, pacman state. The Limine bootloader in particular
lives on a separate vfat ESP and **no btrfs snapshot can revert it** —
see memory/skill notes. Back up `/etc` and `/boot` manually if you care.

## Everyday use

```bash
systemctl --user list-timers restic-backup.timer   # when is it next
systemctl --user start restic-backup.service       # run now
journalctl --user -u restic-backup.service -n 50   # what happened

# manual restore into a temp dir, not over $HOME
restic restore latest --target /tmp/restore
restic check --read-data                            # verify integrity
restic snapshots                                    # history
```

If you ever lose `~/.config/restic/password`, the repo is unrecoverable.
It is not in git on purpose (no GPG key on this machine). Save a copy
somewhere you control, or set up `gpg` and re-add it as an encrypted
chezmoi template.
