#!/usr/bin/env bash
# =============================================================================
# 🚀 NEOVIM CONFIG INSTALLER
# =============================================================================
# Automatically detects your Linux distro (Ubuntu/Debian, Fedora/RHEL, Arch)
# and installs Neovim + all required dependencies + copies this config.
#
# USAGE:
#   chmod +x install.sh
#   ./install.sh
#
# WHAT IT INSTALLS:
#   • Neovim (latest stable)
#   • Git, GCC, Make (build tools for Treesitter)
#   • ripgrep, fd (fast file search for Telescope/Snacks)
#   • Node.js + npm (required by Mason for LSP servers)
#   • lazygit (Git TUI)
#   • lazydocker (Docker TUI)
#   • xclip / wl-clipboard (clipboard support)
#   • curl, wget, unzip (general utilities)
#   • PostgreSQL client (psql — for vim-dadbod database queries)
#
# SAFETY:
#   • Backs up your existing ~/.config/nvim before overwriting
#   • Won't touch your Neovim data (~/.local/share/nvim)
#   • Idempotent — safe to run multiple times
# =============================================================================

set -euo pipefail

# ============================ COLORS =========================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[  ✓ ]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }
step()    { echo -e "\n${CYAN}${BOLD}━━━ $1 ━━━${NC}"; }

# ============================ DISTRO DETECTION ===============================
detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      ubuntu|debian|linuxmint|pop|elementary|zorin|kali)
        DISTRO="debian"
        DISTRO_NAME="$PRETTY_NAME"
        ;;
      fedora|rhel|centos|rocky|alma|nobara)
        DISTRO="fedora"
        DISTRO_NAME="$PRETTY_NAME"
        ;;
      arch|manjaro|endeavouros|garuda|artix|cachyos)
        DISTRO="arch"
        DISTRO_NAME="$PRETTY_NAME"
        ;;
      *)
        error "Unsupported distro: $ID"
        error "This script supports: Ubuntu/Debian, Fedora/RHEL, Arch/Manjaro"
        exit 1
        ;;
    esac
  else
    error "Cannot detect Linux distro (/etc/os-release not found)"
    exit 1
  fi
  success "Detected: $DISTRO_NAME (family: $DISTRO)"
}

# ============================ PACKAGE MANAGERS ===============================
pkg_install() {
  case "$DISTRO" in
    debian)
      sudo apt-get update -qq
      sudo apt-get install -y -qq "$@"
      ;;
    fedora)
      sudo dnf install -y -q "$@"
      ;;
    arch)
      # Use yay if available (for AUR), otherwise pacman
      if command -v yay &>/dev/null; then
        yay -S --noconfirm --needed "$@"
      else
        sudo pacman -S --noconfirm --needed "$@"
      fi
      ;;
  esac
}

# ============================ INSTALL FUNCTIONS ==============================

install_base_deps() {
  step "Installing base dependencies"

  case "$DISTRO" in
    debian)
      pkg_install git gcc g++ make curl wget unzip xclip wl-clipboard \
                  ripgrep fd-find python3 python3-pip
      # fd is called 'fdfind' on Debian/Ubuntu, create symlink
      if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
        sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
        success "Created fd symlink (fdfind → fd)"
      fi
      ;;
    fedora)
      pkg_install git gcc gcc-c++ make curl wget unzip xclip wl-clipboard \
                  ripgrep fd-find python3 python3-pip
      ;;
    arch)
      pkg_install git gcc make curl wget unzip xclip wl-clipboard \
                  ripgrep fd python python-pip
      ;;
  esac
  success "Base dependencies installed"
}

install_neovim() {
  step "Installing Neovim (latest stable)"

  if command -v nvim &>/dev/null; then
    local current_version
    current_version=$(nvim --version | head -1 | grep -oP 'v\K[0-9.]+')
    info "Neovim already installed: v$current_version"

    # Check if version is >= 0.10 (required for this config)
    local major minor
    major=$(echo "$current_version" | cut -d. -f1)
    minor=$(echo "$current_version" | cut -d. -f2)
    if [ "$major" -ge 1 ] || { [ "$major" -eq 0 ] && [ "$minor" -ge 10 ]; }; then
      success "Neovim version is compatible (>= 0.10)"
      return
    else
      warn "Neovim version is too old (< 0.10), upgrading..."
    fi
  fi

  case "$DISTRO" in
    debian)
      # Ubuntu repos may have old versions, use the PPA for latest stable
      if ! grep -q "neovim-ppa" /etc/apt/sources.list.d/* 2>/dev/null; then
        sudo add-apt-repository -y ppa:neovim-ppa/stable
        sudo apt-get update -qq
      fi
      pkg_install neovim
      ;;
    fedora)
      pkg_install neovim
      ;;
    arch)
      pkg_install neovim
      ;;
  esac
  success "Neovim installed: $(nvim --version | head -1)"
}

install_nodejs() {
  step "Installing Node.js + npm (for Mason LSP servers)"

  if command -v node &>/dev/null; then
    info "Node.js already installed: $(node --version)"
  else
    case "$DISTRO" in
      debian)
        # Use NodeSource for latest LTS
        if [ ! -f /etc/apt/sources.list.d/nodesource.list ] && [ ! -f /etc/apt/keyrings/nodesource.gpg ]; then
          curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        fi
        pkg_install nodejs
        ;;
      fedora)
        pkg_install nodejs npm
        ;;
      arch)
        pkg_install nodejs npm
        ;;
    esac
    success "Node.js installed: $(node --version)"
  fi
}

install_psql_client() {
  step "Installing PostgreSQL client (psql — for vim-dadbod)"

  if command -v psql &>/dev/null; then
    info "psql already installed: $(psql --version)"
    return
  fi

  case "$DISTRO" in
    debian)
      pkg_install postgresql-client
      ;;
    fedora)
      pkg_install postgresql
      ;;
    arch)
      pkg_install postgresql-libs
      ;;
  esac
  success "PostgreSQL client installed"
}

install_mysql_client() {
  step "Installing MySQL/MariaDB client (for vim-dadbod)"

  if command -v mysql &>/dev/null; then
    info "MySQL client already installed"
    return
  fi

  case "$DISTRO" in
    debian)
      pkg_install default-mysql-client || pkg_install mariadb-client || warn "MySQL client not available, skipping"
      ;;
    fedora)
      pkg_install mariadb || warn "MySQL client not available, skipping"
      ;;
    arch)
      pkg_install mariadb-clients || warn "MySQL client not available, skipping"
      ;;
  esac
  if command -v mysql &>/dev/null; then
    success "MySQL client installed"
  fi
}

install_lazygit() {
  step "Installing lazygit (Git TUI)"

  if command -v lazygit &>/dev/null; then
    info "lazygit already installed: $(lazygit --version | grep -oP 'version=\K[0-9.]+')"
    return
  fi

  case "$DISTRO" in
    arch)
      pkg_install lazygit
      ;;
    *)
      # Install from GitHub releases (works on any distro)
      local version
      version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -oP '"tag_name": "v\K[0-9.]+')
      if [ -z "$version" ]; then
        warn "Could not fetch latest lazygit version, skipping"
        return
      fi
      local url="https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_Linux_x86_64.tar.gz"
      local tmpdir
      tmpdir=$(mktemp -d)
      curl -Lo "$tmpdir/lazygit.tar.gz" "$url"
      tar -xzf "$tmpdir/lazygit.tar.gz" -C "$tmpdir"
      sudo install "$tmpdir/lazygit" /usr/local/bin/
      rm -rf "$tmpdir"
      ;;
  esac
  success "lazygit installed"
}

install_lazydocker() {
  step "Installing lazydocker (Docker TUI)"

  if command -v lazydocker &>/dev/null; then
    info "lazydocker already installed"
    return
  fi

  case "$DISTRO" in
    arch)
      # Available in AUR
      if command -v yay &>/dev/null; then
        yay -S --noconfirm --needed lazydocker
      else
        warn "lazydocker requires yay (AUR helper) on Arch. Install yay first."
        return
      fi
      ;;
    *)
      # Install from GitHub releases
      local version
      version=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -oP '"tag_name": "v\K[0-9.]+')
      if [ -z "$version" ]; then
        warn "Could not fetch latest lazydocker version, skipping"
        return
      fi
      local url="https://github.com/jesseduffield/lazydocker/releases/download/v${version}/lazydocker_${version}_Linux_x86_64.tar.gz"
      local tmpdir
      tmpdir=$(mktemp -d)
      curl -Lo "$tmpdir/lazydocker.tar.gz" "$url"
      tar -xzf "$tmpdir/lazydocker.tar.gz" -C "$tmpdir"
      sudo install "$tmpdir/lazydocker" /usr/local/bin/
      rm -rf "$tmpdir"
      ;;
  esac
  success "lazydocker installed"
}

# ============================ CONFIG INSTALLATION ============================

install_config() {
  step "Installing Neovim configuration"

  local config_dir="$HOME/.config/nvim"
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # Back up existing config if it exists and is different from ours
  if [ -d "$config_dir" ]; then
    # Check if it's already our config (has lazyvim.json)
    if [ "$script_dir" = "$config_dir" ]; then
      info "Config is already in the right place ($config_dir)"
      return
    fi

    local backup_dir="$HOME/.config/nvim.bak.$(date +%Y%m%d_%H%M%S)"
    warn "Existing config found at $config_dir"
    info "Backing up to: $backup_dir"
    mv "$config_dir" "$backup_dir"
    success "Backup created: $backup_dir"
  fi

  # Copy config
  mkdir -p "$config_dir"
  info "Copying config from $script_dir to $config_dir"

  # Copy everything except install.sh, .git, and binary files
  rsync -a --exclude='.git' \
           --exclude='install.sh' \
           --exclude='lazygit' \
           --exclude='lazydocker' \
           --exclude='*.tar.gz' \
           --exclude='*.zip' \
           "$script_dir/" "$config_dir/"

  success "Config installed to $config_dir"
}

# ============================ PLUGIN SYNC ====================================

sync_plugins() {
  step "Syncing Neovim plugins (this may take a moment)"

  if command -v nvim &>/dev/null; then
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    success "Plugins synced"
  else
    warn "Neovim not found, skipping plugin sync"
  fi
}

# ============================ SUMMARY ========================================

print_summary() {
  echo ""
  echo -e "${GREEN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}${BOLD}║           ✅  INSTALLATION COMPLETE!                        ║${NC}"
  echo -e "${GREEN}${BOLD}╠══════════════════════════════════════════════════════════════╣${NC}"
  echo -e "${GREEN}${BOLD}║                                                              ║${NC}"
  echo -e "${GREEN}${BOLD}║  Start Neovim:          nvim                                 ║${NC}"
  echo -e "${GREEN}${BOLD}║  Open file explorer:    <leader>e                            ║${NC}"
  echo -e "${GREEN}${BOLD}║  Find files:            <leader><space>                      ║${NC}"
  echo -e "${GREEN}${BOLD}║  Open terminal:         <C-\\>                                ║${NC}"
  echo -e "${GREEN}${BOLD}║  Open LazyDocker:       <leader>td                           ║${NC}"
  echo -e "${GREEN}${BOLD}║  Open Database UI:      <leader>db                           ║${NC}"
  echo -e "${GREEN}${BOLD}║  Open LazyGit:          <leader>gg                           ║${NC}"
  echo -e "${GREEN}${BOLD}║                                                              ║${NC}"
  echo -e "${GREEN}${BOLD}║  Config location:       ~/.config/nvim                       ║${NC}"
  echo -e "${GREEN}${BOLD}║  Plugin data:           ~/.local/share/nvim                  ║${NC}"
  echo -e "${GREEN}${BOLD}║                                                              ║${NC}"
  echo -e "${GREEN}${BOLD}║  Press <leader> and wait to see all keybinds (which-key)     ║${NC}"
  echo -e "${GREEN}${BOLD}║                                                              ║${NC}"
  echo -e "${GREEN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"
  echo ""

  # Check for any missing tools
  local missing=()
  command -v nvim &>/dev/null || missing+=("neovim")
  command -v lazygit &>/dev/null || missing+=("lazygit")
  command -v lazydocker &>/dev/null || missing+=("lazydocker")
  command -v node &>/dev/null || missing+=("nodejs")
  command -v rg &>/dev/null || missing+=("ripgrep")
  command -v fd &>/dev/null || missing+=("fd")
  command -v psql &>/dev/null || missing+=("psql")

  if [ ${#missing[@]} -gt 0 ]; then
    warn "Some tools could not be installed automatically: ${missing[*]}"
    warn "You may need to install them manually."
  else
    success "All dependencies verified! 🎉"
  fi
}

# ============================ MAIN ===========================================

main() {
  echo -e "${CYAN}${BOLD}"
  echo "  ╔═══════════════════════════════════════════════╗"
  echo "  ║     🚀 Neovim Config Installer               ║"
  echo "  ║     Ubuntu / Fedora / Arch Auto-Detected      ║"
  echo "  ╚═══════════════════════════════════════════════╝"
  echo -e "${NC}"

  # Check if running as root (we need sudo, not root)
  if [ "$(id -u)" -eq 0 ]; then
    error "Do not run this script as root. Run as your normal user (it will use sudo when needed)."
    exit 1
  fi

  detect_distro
  install_base_deps
  install_neovim
  install_nodejs
  install_psql_client
  install_mysql_client
  install_lazygit
  install_lazydocker
  install_config
  sync_plugins
  print_summary
}

main "$@"
