

mkdir ~/downloads -p
sudo apt install wget libfuse2 ripgrep fuse -y
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo mv nvim.appimage /usr/local/bin
chmod u+x /usr/local/bin/nvim.appimage

CUSTOM_NVIM_PATH=/usr/local/bin/nvim.appimage # Add this to bash|zshrc
sudo update-alternatives --install /usr/bin/nvim nvim "${CUSTOM_NVIM_PATH}" 110

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
