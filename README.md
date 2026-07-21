# install-update-antigravity-ubuntu

One-shot script to install/update Antigravity IDE on Ubuntu.

Handles first-time install and future updates with the same command — extracts the tarball, fixes the Chromium sandbox permissions, sets up a desktop entry (search/pin support), and launches the app.

## Requirements

- Ubuntu (or any Debian-based distro)
- `sudo` access (needed once to fix sandbox permissions)
- Downloaded tarball from [antigravity.google/download](https://antigravity.google/download) named exactly `Antigravity IDE.tar.gz`, placed in `~/Downloads/`

## Usage

1. Download the latest `Antigravity IDE.tar.gz` to `~/Downloads/`
2. Run:

```bash
   ./update-antigravity.sh
```

3. Enter your sudo password when prompted (sandbox permission fix)

That's it — the app launches automatically once done. Run the same script again whenever a new version comes out.

## What it does

- Closes any running instance of Antigravity IDE
- Extracts the new tarball and replaces the old install at `~/.local/share/antigravity-ide`
- Fixes `chrome-sandbox` ownership/permissions (required for Electron sandboxing to work)
- Creates a `.desktop` entry on first run only, so the app is searchable and pinnable from the app menu/taskbar
- Deletes the used tarball
- Launches the app

## Notes

- Safe to run on a machine with no prior install — same script handles first install and updates identically
- Your settings/extensions are stored separately (`~/.config/Antigravity`, `~/.antigravity`) and are untouched by this script
