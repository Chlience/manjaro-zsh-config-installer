#!/bin/bash
# This script installs the Manjaro Zsh configuration and its dependencies.
# Please make sure you have installed Zsh before running this script.

# Configuration variables
TMP_DIR="/tmp/manjaro-zsh-config"  # Configurable temporary directory

# Enable strict mode:
set -euo pipefail

# Error handling function
error_exit() {
    echo "[ERROR] Line $1: $2" >&2
    exit 1
}

# Verify zsh is installed
check_zsh() {
    if ! command -v zsh >/dev/null 2>&1; then
        error_exit $LINENO "Zsh is not installed. Please install zsh first."
    fi
}

# Cleanup function to remove temp directory
cleanup() {
    if [ -d "${TMP_DIR}" ]; then
        echo "Cleaning up temporary files..."
        rm -rf "${TMP_DIR}" || \
            error_exit $LINENO "Failed to clean up temporary files"
    fi
}

# Main installation function
install_manjaro_zsh() {
    echo "Starting Manjaro Zsh configuration installation..."
    
    # Register cleanup trap (will run on script exit)
    trap cleanup EXIT

    # Create temporary working directory
    if ! mkdir -p "${TMP_DIR}"; then
        error_exit $LINENO "Failed to create temporary directory ${TMP_DIR}"
    fi
    
    # Change to temp directory
    cd "${TMP_DIR}" || error_exit $LINENO "Failed to enter temporary directory ${TMP_DIR}"

    # Clone repositories
    echo "Cloning repositories..."
    for repo in \
        "https://github.com/Chrysostomus/manjaro-zsh-config.git" \
        "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "https://github.com/zsh-users/zsh-history-substring-search.git" \
        "https://github.com/zsh-users/zsh-autosuggestions.git" \
        "https://github.com/romkatv/powerlevel10k.git"
    do
        if ! git clone "$repo"; then
            error_exit $LINENO "Failed to clone $repo"
        fi
    done

    # Modify configuration
    sed -i '/^USE_POWERLINE=/s/=.*/="false"/' manjaro-zsh-config/.zshrc || \
        error_exit $LINENO "Failed to modify .zshrc"

    # Backup existing config
    if [ -f ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.bak || \
            error_exit $LINENO "Failed to backup existing .zshrc"
    fi

    # Install new config
    cp ./manjaro-zsh-config/.zshrc ~/ || \
        error_exit $LINENO "Failed to copy new .zshrc"

    # Create system directories
    sudo mkdir -p /usr/share/zsh/plugins || \
        error_exit $LINENO "Failed to create plugin directories"
    
    # Copy components
    sudo cp -r ./manjaro-zsh-config/* /usr/share/zsh/ || \
        error_exit $LINENO "Failed to copy manjaro config"
    
    sudo cp -r ./zsh-syntax-highlighting /usr/share/zsh/plugins/ || \
        error_exit $LINENO "Failed to copy syntax highlighting"
    
    sudo cp -r ./zsh-history-substring-search /usr/share/zsh/plugins/ || \
        error_exit $LINENO "Failed to copy history substring search"
    
    sudo cp -r ./zsh-autosuggestions /usr/share/zsh/plugins/ || \
        error_exit $LINENO "Failed to copy autosuggestions"
    
    sudo cp -r ./powerlevel10k /usr/share/zsh-theme-powerlevel10k || \
        error_exit $LINENO "Failed to copy powerlevel10k"

    echo "Installation completed successfully!"
    echo "Please restart your terminal or run 'source ~/.zshrc'"
    echo "To enable powerline, install a Nerd Font and set USE_POWERLINE=\"true\" in ~/.zshrc"
}

# Main execution flow
main() {
    check_zsh
    install_manjaro_zsh
}

main "$@"