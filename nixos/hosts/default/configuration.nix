{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Kaliningrad";
  i18n.defaultLocale = "ru_RU.UTF-8";

  # SDDM на Xorg
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Hyprland (Wayland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG portal для Wayland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Звук
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Пользователь
  users.users.cuc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    xdg-utils
    wayland-utils
    wl-clipboard
    libnotify
  ];

  # Разрешить unfree
  nixpkgs.config.allowUnfree = true;

  # Включить flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  system.stateVersion = "24.11";
}
