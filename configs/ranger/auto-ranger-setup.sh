#!/usr/bin/bash

install_ranger() {
  CONFIGDIR=$HOME'/.config/ranger'

  [[ ! -d $CONFIGDIR ]] && mkdir -p "$CONFIGDIR"

  cp -rv colorschemes rc.conf rifle.conf scope.sh "$CONFIGDIR"

  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    source /etc/os-release
    OS=$ID
  else
    printf "%s" "Could not detect distro"
    exit 1
  fi

  if [[ "$OS" == "arch" ]]; then
    # Check if ranger is installed
    [[ -x $(command -v ranger) ]] || sudo pacman -S --needed --noconfirm ranger

    # Images thumbnails
    # For pictures preview
    # NO MORE MANTAINED USE THE AUR PACKAGE
    # sudo pacman -S --needed --noconfirm ueberzug

    # For epub preview
    # Check if pip is installed
    [[ -x $(command pip) ]] || sudo pacman -S --needed --noconfirm python-pip
    # Install Pillow dependecy if not installed'
    [[ $(python -c "import PIL") ]] || sudo pacman -S --needed --noconfirm python-pillow

    # Video thumbnailer
    sudo pacman -S --needed --noconfirm ffmpeg ffmpegthumbnailer

  elif [[ "$OS" == "fedora" ]]; then
    # Check if ranger is installed
    [[ -x $(command -v ranger) ]] || sudo dnf install -y ranger

    # Images thumbnails
    # For pictures preview build ueberzugpp manually
    # https://github.com/jstkdng/ueberzugpp

    # For epub preview
    # Check if pip is installed
    [[ -x $(command pip) ]] || sudo dnf install -y python-pip

    # Install Pillow dependecy if not installed'
    [[ $(python -c "import PIL") ]] && pip install Pillow

    # Video thumbnailer
    sudo dnf install -y ffmpeg ffmpegthumbnailer
  fi

  # Build epub-thumbnailer from source and clean
  # Install dependecy globaly with python -m pip install Pillow
  git clone https://github.com/marianosimone/epub-thumbnailer.git \
    && sudo python epub-thumbnailer/install.py install \
    && rm -rf epub-thumbnailer

  # Ranger icons plugin
  git clone https://github.com/alexanderjeurissen/ranger_devicons.git ~/.config/ranger/plugins/ranger_devicons
  echo "default_linemode devicons" >>"$CONFIGDIR"/rc.conf

  # Ranger zoxide plugin
  git clone https://github.com/jchook/ranger-zoxide.git ~/.config/ranger/plugins/zoxide
}

# Ask for confirmation
read -rp "Do you want to install ranger? (Y/n)" answer

doInstall=${answer:-Y}

case $doInstall in
  [Yy]) install_ranger ;;
  [Nn]) exit 0 ;;
  *)
    echo "Incorrect option"
    exit 1
    ;;
esac
