

mkdir ~/downloads -p
sudo apt install wget libfuse2 ripgrep fuse -y

# Node & npm installation
sudo apt install nodejs npm -y
# Rust & cargo installation
curl https://sh.rustup.rs -sSf | sh

NVIM_IMAGE_NAME=nvim-linux-x86_64.appimage
wget https://github.com/neovim/neovim/releases/download/v0.11.4/${NVIM_IMAGE_NAME}
sudo mv ${NVIM_IMAGE_NAME} /usr/local/bin
chmod u+x /usr/local/bin/${NVIM_IMAGE_NAME}

# TODO: # Overwrite this variable in bash|zshrc file
CUSTOM_NVIM_PATH=/usr/local/bin/${NVIM_IMAGE_NAME}

sudo update-alternatives --install /usr/bin/nvim nvim "${CUSTOM_NVIM_PATH}" 110

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/harristomy/kickstart.nvim ~/.config/nvim --depth 1 && nvim
