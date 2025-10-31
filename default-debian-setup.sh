# Run this as sudo

echo -e "\e[3;4;36mRunning Harris' very opinionated setup.\e[0m"

# Optional apt dist-upgrade -y

apt modernize-sources -y && apt update && apt clean

apt install build-essential fuse libfuse2 git ninja-build ripgrep wget -y

apt install eza less bat autojump -y

# Use python rich module to print out MD files with nicer formatting
wget https://raw.githubusercontent.com/harristomy/machine-setup/main/mdcat.py
mkdir -p ~/scripts
cp --force mdcat.py ~/scripts/mdcat.py
rm mdcat.py

# Install zsh
apt install zsh -y
chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh-autocomplete
git clone https://github.com/marlonrichert/zsh-autocomplete.git  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete;

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# This section can be commented/removed if you are not using my .zshrc
# It requires the .zshrc file to be in the same directory as this install script
wget https://raw.githubusercontent.com/harristomy/machine-setup/main/.debian_zshrc
cp --force .debian_zshrc ~/.zshrc
rm .debian_zshrc
