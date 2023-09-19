#!/bin/bash

# 07 AUG 2023 - v1.0.0
# This is Harris Tomy's opinionated zsh and VSCode setup for Debian/Ubuntu :) have fun.
# Note: Run source ~/.zshrc after the script is finished, or open a new zsh shell.
# ! Note: If running this in a Docker container, then you will need to attach to the running container in VSCode so that code server is setup
# !       and the extensions can be installed

# Install zsh
sudo apt install zsh -y
sudo chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Other utils
sudo apt install autojump exa bat less -y

# Compilers, package managers, etc TODO: Add rust/cargo utils here
# sudo apt install npm 

# This section can be commented/removed if you are not using my .zshrc
# It requires the .zshrc file to be in the same directory as this install script
cp --force .zshrc ~/.zshrc

# List of extensions to install
extensions=(
    "alexkrechik.cucumberautocomplete"               # Cucumber (Gherkin) Autocomplete
    "medo64.render-crlf"                             # Render Line Endings
    "DavidAnson.vscode-markdownlint"                 # Markdownlint
    "DotJoshJohnson.xml"                             # XML
    "eamodio.gitlens"                                # GitLens - Git supercharged
    "GitLab.gitlab-workflow"                         # GitLab Workflow
    "Gruntfuggly.todo-tree"                          # Todo Tree
    "rioj7.command-variable"                         # Command Variable
    "adpyke.codesnap"                                # CodeSnap
    "ms-vscode.hexeditor"                            # HexEditor
    "ryu1kn.partial-diff"                            # Partial Diff
    "streetsidesoftware.code-spell-checker"          # Code Spell Checker
    "trond-snekvik.gnu-mapfiles"                     # GNU mapfiles (syntax highlighting)
    "tamasfe.even-better-toml"                       # Even Better Toml
    "ms-vsliveshare.vsliveshare"                     # Live Share
    "nordic-semiconductor.nrf-devicetree"            # Nordic Semiconductor nRF DeviceTree
    "nordic-semiconductor.nrf-kconfig"               # Nordic Semiconductor nrf Kconfig
    "redhat.vscode-yaml"                             # YAML
    "ms-python.vscode-pylance"                       # Pylance
    "ms-python.black-formatter"                      # Python Black formatter
    "ms-python.python"                               # Python
    "twxs.cmake"                                     # CMake
    "llvm-vs-code-extensions.vscode-clangd"          # Clangd
    "matepek.vscode-catch2-test-adapter"             # Catch2 Test runner
    "ms-vscode.cpptools"                             # C/C++ Tools
    "marus25.cortex-debug"                           # Cortex-Debug
)

# Install each extension
total=${#extensions[@]}
installed=0

for extension in "${extensions[@]}"; do
    code --install-extension "$extension" >/dev/null 2>&1
    installed=$((installed + 1))
    printf "Installed: %s (%d/%d)\n" "$extension" "$installed" "$total"
done

# Print completion message
echo "\e[32mInstallation completed.\e[0m"
