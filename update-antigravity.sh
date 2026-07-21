#!/bin/bash
set -e

TARBALL="$HOME/Downloads/Antigravity IDE.tar.gz"
INSTALL_DIR="$HOME/.local/share/antigravity-ide"
DESKTOP_FILE="$HOME/.local/share/applications/antigravity-ide.desktop"
ICON_PATH="$INSTALL_DIR/resources/app/resources/linux/code.png"
TMP_DIR="/tmp/antigravity-update-$$"

if [ ! -f "$TARBALL" ]; then
    echo "Error: '$TARBALL' not found. Download the new version first."
    exit 1
fi

echo "==> Closing running instance (if any)..."
pkill -f antigravity-ide || true
sleep 1

echo "==> Extracting new version to temp dir..."
mkdir -p "$TMP_DIR"
tar -xzf "$TARBALL" -C "$TMP_DIR"

echo "==> Removing old install..."
rm -rf "$INSTALL_DIR"

echo "==> Installing new version..."
mv "$TMP_DIR/Antigravity IDE" "$INSTALL_DIR"
rmdir "$TMP_DIR" 2>/dev/null || true

echo "==> Fixing sandbox permissions..."
sudo chown root:root "$INSTALL_DIR/chrome-sandbox"
sudo chmod 4755 "$INSTALL_DIR/chrome-sandbox"

echo "==> Checking desktop entry..."
if [ ! -f "$DESKTOP_FILE" ]; then
    echo "==> Not found, creating it..."
    mkdir -p "$HOME/.local/share/applications"
    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Antigravity IDE
Comment=Antigravity IDE
Exec=$INSTALL_DIR/antigravity-ide %F
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Development;IDE;
StartupWMClass=antigravity-ide
EOF
    update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
else
    echo "==> Already exists, skipping."
fi

echo "==> Cleaning up downloaded tarball..."
rm -f "$TARBALL"

echo "==> Done. Launching to verify..."
"$INSTALL_DIR/antigravity-ide" &
