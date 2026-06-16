{ config, pkgs, ... }:

{
  home.username = "cuc";
  home.homeDirectory = "/home/cuc";
  home.stateVersion = "24.11";

  # Разрешить home-manager управлять собой
  programs.home-manager.enable = true;

  # Пакеты уровня пользователя
  home.packages = with pkgs; [
    btop
    hyprpaper
    hyprlock
    hypridle
    rofi
    kitty
    dunst
    grim
    slurp
    brightnessctl
    ddcutil
    wl-clipboard
    xdg-desktop-portal-hyprland
    yazi

    inputs.zen-browser.packages.${pkgs.system}.default
    keepassxc
    amnezia-vpn-bin
    telegram-desktop
    transmission
    obsidian

    python3
    python3Packages.pip
    gcc
    sage
  ];

  # ── Конфиги в ~/.config/ ──────────────────────────────────────────────

  # Hyprland — ~/.config/hypr/
  xdg.configFile."hypr/hyprland.conf".source  = /home/cuc/.git/dots/CucDots/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = /home/cuc/.git/dots/CucDots/hypr/hyprpaper.conf;

  # Kitty — ~/.config/kitty/
  xdg.configFile."kitty/kitty.conf".source = /home/cuc/.git/dots/CucDots/kitty/kitty.conf;

  # rofi — ~/.config/rofi/
  xdg.configFile."rofi/config".source    = /home/cuc/.git/dots/CucDots/rofi/config;
  xdg.configFile."rofi/style.css".source = /home/cuc/.git/dots/CucDots/rofi/style.css;

  # nvim — ~/.config/nvim/
  xdg.configFile."nvim" = {
    source    = /home/cuc/.git/dots/CucDots/nvim;
    recursive = true;
  };

  home.file.".config/nvim/lazy-lock.json" = {
    source = /home/cuc/.git/dots/CucDots/nvim/lazy-lock.json;
  };

  # ── Конфиги в ~/ ──────────────────────────────────────────────

  # zsh — ~/
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";  # держит всё в ~/.config/zsh/ вместо ~/

    initExtra    = builtins.readFile /home/cuc/.git/dots/CucDots/zsh/.zshrc;
    envExtra     = builtins.readFile /home/cuc/.git/dots/CucDots/zsh/.zshenv;
    profileExtra = builtins.readFile /home/cuc/.git/dots/CucDots/zsh/.zprofile;
  };

  # XDG dirs
  xdg.userDirs = {
    enable            = true;
    createDirectories = true;
    download          = "${config.home.homeDirectory}/dl";
    documents         = "${config.home.homeDirectory}/doc";
    pictures          = "${config.home.homeDirectory}/pic";
  };

}
