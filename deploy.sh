#!/bin/sh
set -eu

if ! command -v hugo >/dev/null 2>&1; then
  hugo_version=0.139.4
  case "$(uname -m)" in
    aarch64|arm64) hugo_arch=arm64 ;;
    *) hugo_arch=amd64 ;;
  esac
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/hugo.tar.gz" \
    "https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/hugo_extended_${hugo_version}_linux-${hugo_arch}.tar.gz"
  tar -xzf "$tmp/hugo.tar.gz" -C "$tmp" hugo
  mv "$tmp/hugo" /tmp/hugo
  chmod +x /tmp/hugo
  export PATH="/tmp:${PATH}"
fi

hugo version
hugo --gc
