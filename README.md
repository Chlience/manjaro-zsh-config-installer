# Manjaro Zsh Configuration Installer

A bash script to automatically install the Manjaro Zsh configuration with popular plugins and themes.

## Features
- Installs Manjaro's curated Zsh configuration
- Includes essential plugins:
  - zsh-syntax-highlighting
  - zsh-history-substring-search
  - zsh-autosuggestions
- Installs Powerlevel10k theme (with powerline disabled by default)
- Automatic backup of existing `.zshrc`
- Clean error handling and recovery

## Prerequisites
- Zsh (script will check and notify if missing)
- Git
- sudo privileges (for system-wide installation)

## Installation
1. Download the script:
```bash
curl -O https://raw.githubusercontent.com/Chlience/manjaro-zsh-config-installer/main/manjaro-zsh-config-install.sh
```

2. Make it executable:
```bash
chmod +x manjaro-zsh-config-install.sh
```

3. Run the installer:
```bash
./manjaro-zsh-config-install.sh
```

## Post-Installation
After successful installation:
1. Restart your terminal or run:
   source ~/.zshrc

2. (Optional) To enable powerline in Powerlevel10k:
   - Install a Nerd Font (https://www.nerdfonts.com/)
   - Edit ~/.zshrc and change:
```bash
USE_POWERLINE="true"
```

## Customization
You can modify these variables at the top of the script:
TMP_DIR="/tmp/manjaro-zsh-config"  # Change temporary working directory

## Troubleshooting
If you encounter issues:
1. Check error messages - they include line numbers for debugging
2. Verify you have all prerequisites installed
3. The script automatically creates ~/.zshrc.bak if you had an existing config
4. Temporary files are automatically cleaned up on exit

## Uninstallation
To revert changes:
1. Restore your original zsh config:
```bash
mv ~/.zshrc.bak ~/.zshrc
```

2. Remove installed components:
```bash
sudo rm -rf /usr/share/zsh/plugins/zsh-*
sudo rm -rf /usr/share/zsh-theme-powerlevel10k
```

License
MIT License - Free to use and modify

Note: This is an unofficial installer. The Manjaro Zsh configuration is maintained by the Manjaro team.