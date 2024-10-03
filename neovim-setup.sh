

mkdir ~/downloads -p
sudo apt install wget libfuse2 ripgrep fuse -y

# Node & npm installation
sudo apt install nodejs npm
# Rust & cargo installation
curl https://sh.rustup.rs -sSf | sh

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo mv nvim.appimage /usr/local/bin
chmod u+x /usr/local/bin/nvim.appimage

CUSTOM_NVIM_PATH=/usr/local/bin/nvim.appimage # Add this to bash|zshrc
sudo update-alternatives --install /usr/bin/nvim nvim "${CUSTOM_NVIM_PATH}" 110

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/starter ~/.config/nvim --depth 1 && nvim
