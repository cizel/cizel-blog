#!/bin/sh
# Install a known Hugo and build the site. Does not clone themes.
set -eu

hugo_version=0.168.0
case "$(uname -m)" in
  aarch64|arm64) hugo_arch=arm64 ;;
  *) hugo_arch=amd64 ;;
esac

bindir="${HOME}/.local/bin"
mkdir -p "$bindir"
url="https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/hugo_extended_${hugo_version}_linux-${hugo_arch}.tar.gz"
tmp="$(mktemp -d)"
echo "Installing Hugo ${hugo_version} for linux-${hugo_arch}"
curl -fsSL -o "$tmp/hugo.tar.gz" "$url"
tar -xzf "$tmp/hugo.tar.gz" -C "$bindir" hugo
chmod +x "$bindir/hugo"
rm -rf "$tmp"

"$bindir/hugo" version
"$bindir/hugo" --gc
