#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for the rest of this script (Apple Silicon)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  success "Homebrew installed"
else
  success "Homebrew already installed"
fi

# ── Brew bundle ───────────────────────────────────────────────────────────────
if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
  info "Installing packages from Brewfile..."
  brew bundle install --file="$DOTFILES_DIR/Brewfile"
  success "Brew packages installed"
else
  warn "No Brewfile found, skipping"
fi

# ── Symlinks ──────────────────────────────────────────────────────────────────
info "Creating symlinks..."
make -C "$DOTFILES_DIR" sync-symlinks
success "Symlinks created"

# ── bob (Neovim version manager) ─────────────────────────────────────────────
if command -v bob &>/dev/null; then
  NVIM_VERSION="nightly"
  if ! bob list 2>/dev/null | grep -q "$NVIM_VERSION"; then
    info "Installing Neovim $NVIM_VERSION via bob..."
    bob install "$NVIM_VERSION"
  fi
  bob use "$NVIM_VERSION"
  success "Neovim $NVIM_VERSION active via bob"
else
  warn "bob not found, skipping Neovim installation"
fi

# ── Neovim config ─────────────────────────────────────────────────────────────
info "Configuring Neovim (minimal)..."
make -C "$DOTFILES_DIR" nvim-configure-minimal
success "Neovim configured"

# ── asdf ──────────────────────────────────────────────────────────────────────
ASDF_SH="$(brew --prefix asdf 2>/dev/null)/libexec/asdf.sh"
if [[ -f "$ASDF_SH" ]]; then
  # shellcheck source=/dev/null
  source "$ASDF_SH"

  declare -A ASDF_PLUGINS=(
    [bun]=""
    [golang]="https://github.com/asdf-community/asdf-golang.git"
    [golangci-lint]=""
    [nodejs]="https://github.com/asdf-vm/asdf-nodejs.git"
    [python]=""
    [ruby]="https://github.com/asdf-vm/asdf-ruby.git"
  )

  info "Adding asdf plugins..."
  for plugin in "${!ASDF_PLUGINS[@]}"; do
    if asdf plugin list 2>/dev/null | grep -q "^${plugin}$"; then
      success "asdf plugin already installed: $plugin"
    else
      url="${ASDF_PLUGINS[$plugin]}"
      if [[ -n "$url" ]]; then
        asdf plugin add "$plugin" "$url"
      else
        asdf plugin add "$plugin"
      fi
      success "asdf plugin added: $plugin"
    fi
  done

  info "Installing asdf versions from ~/.tool-versions..."
  asdf install
  success "asdf versions installed"
else
  warn "asdf not found, skipping runtime version setup"
fi

# ── Rust (rustup) ─────────────────────────────────────────────────────────────
if command -v rustup &>/dev/null; then
  success "rustup already installed"
  rustup update stable
else
  info "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  source "$HOME/.cargo/env"
  success "Rust installed"
fi

# ── Tmux plugin manager ───────────────────────────────────────────────────────
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  info "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  success "TPM installed — press prefix+I in tmux to install plugins"
else
  success "TPM already installed"
fi

# ── Fish shell ────────────────────────────────────────────────────────────────
FISH_PATH="$(command -v fish 2>/dev/null || true)"
if [[ -n "$FISH_PATH" ]]; then
  if ! grep -qF "$FISH_PATH" /etc/shells; then
    info "Adding fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  if [[ "$SHELL" != "$FISH_PATH" ]]; then
    info "Setting fish as default shell..."
    chsh -s "$FISH_PATH"
    success "Default shell changed to fish — re-login to apply"
  else
    success "Fish is already the default shell"
  fi
else
  warn "fish not found, skipping shell change"
fi

echo ""
echo "Bootstrap complete. Open a new terminal to apply shell changes."
