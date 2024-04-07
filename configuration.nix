# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  ## Fix function key mapping
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  networking.hostName = "jpc-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  ## Settings for Gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome.enable = true;

  ## Settings for KDE Plasma
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.displayManager.sddm.wayland.enable = false;
  services.xserver.desktopManager.plasma5.enable = false; # Plasma 5
  # services.desktopManager.plasma5.enable = false; # Plasma 6 (Required unstable)

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Configure Nvidia stuff
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.john = {
    isNormalUser = true;
    description = "John";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.john = {
    imports = [ ./home-manager/home.nix ];
    dconf = {
      enable = true;
	  settings = {
	    "org/gnome/desktop/interface" = {
              overlay-scrolling = false;
	      color-scheme = "prefer-dark";
            };

            "org/gnome/desktop/wm/keybindings" = {
              move-to-workspace-1 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-2 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-3 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-4 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-5 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-6 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-7 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-8 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-9 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-10 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-11 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-12 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-left = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-right = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-up = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-down = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              move-to-workspace-last = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-1 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-2 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-3 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-4 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-5 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-6 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-7 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-8 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-9 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-10 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-11 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-12 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-left = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-right = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-up = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-down = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
              switch-to-workspace-last = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            };

            "org/gnome/desktop/wm/preferences" = {
              num-workspaces = "1";
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
              custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
              ];
              home = ["<Super>e"];
              magnifier = ["<Alt><Super>8"];
              magnifier-zoom-in = ["<Alt><Super>equal"];
              magnifier-zoom-out = ["<Alt><Super>minus"];
              mic-mute = ["<Shift><Control><Super>m"];
              next = ["<Ctrl><Super>Right"];
              play = ["<Ctrl><Super>space"];
              playback-forward = ["<Shift><Ctrl><Super>Right"];
              playback-rewind = ["<Shift><Ctrl><Super>Left"];
              previous = ["<Ctrl><Super>Left"];
              screensaver = ["<Super>l"];
              volume-down-precise = ["<Ctrl><Super>Down"];
              volume-mute = ["<Ctrl><Super>m"];
              volume-up-precise = ["<Ctrl><Super>Up"];
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
              binding = "<Ctrl><Alt>t";
              command = "alacritty -e zsh -c 'zellij attach --index 0 || zellij'";
              name = "Alacritty";
            };

	    "org/gnome/shell" = {
              disable-user-extensions = false;
	      disabled-extensions = [ "disabled" ];
	      enabled-extensions = [
	       "appindicatorsupport@rgcjonas.gmail.com"
               "dash-to-panel@jderose9.github.com" 
	      ];
	    };

            "org/gnome/shell/window-switcher" = {
              current-workspace-only = true;
            };
	  };
    };
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
    home.stateVersion = "23.11";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    neovim
    keepassxc
    git
    git-lfs
    xclip
    xsel
    google-drive-ocamlfuse
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnome.adwaita-icon-theme
    gnome.mutter
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    #XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome-photos
    gnome-tour
    gedit
    epiphany
  ]) ++ (with pkgs.gnome; [
    geary
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.zsh.enable = true;

  systemd.user.services.googleDriveOcamlFuse = {
    enable = false;
    description = "FUSE filesystem over Google Drive";
    after = ["network.target"];
    serviceConfig = {
      ExecStart = "google-drive-ocamlfuse /home/john/google-drive";
      ExecStop = "fusermount -u /home/john/google-drive";
      Restart = "always";
      Type = "forking";
    };
    wantedBy = ["default.target"];
  };

  # List services that you want to enable:
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # NixOS Overlays
  nixpkgs.overlays = [
    (final: prev: {
      # elements of pkgs.gnome must be taken from gfinal and gprev
      gnome = prev.gnome.overrideScope' (gfinal: gprev: {
        mutter = gprev.mutter.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or []) ++ [
	    # https://salsa.debian.org/gnome-team/mutter/-/blob/ubuntu/master/debian/patches/ubuntu/x11-Add-support-for-fractional-scaling-using-Randr.patch
            (prev.fetchpatch {
              url = "https://salsa.debian.org/gnome-team/mutter/-/raw/f0a4b16dd0a5d66d7b27fdf3de5bc61dbea5954e/debian/patches/ubuntu/x11-Add-support-for-fractional-scaling-using-Randr.patch";
              hash = "sha256-YoXT1xmah/RhYkzxpKreHOhCX/okV6EHQWyOslSStlA=";
            })
          ];
        });
        gnome-control-center = gprev.gnome-control-center.overrideAttrs (oldAttrs: {
          patches = oldAttrs.patches ++ [
            # https://salsa.debian.org/gnome-team/gnome-control-center/-/blob/ubuntu/master/debian/patches/ubuntu/display-Support-UI-scaled-logical-monitor-mode.patch
            (prev.fetchpatch {
              url = "https://salsa.debian.org/gnome-team/gnome-control-center/-/raw/4c339157663b95cc66eda1457850ecf2ce504113/debian/patches/ubuntu/display-Support-UI-scaled-logical-monitor-mode.patch";
              hash = "sha256-InDpZr6D99aBGWQbDFPrONQSs3mkcKZWcCIDdZ6LUh0=";
            })
            # https://salsa.debian.org/gnome-team/gnome-control-center/-/blob/ubuntu/master/debian/patches/ubuntu/display-Allow-fractional-scaling-to-be-enabled.patch
            (prev.fetchpatch {
              url = "https://salsa.debian.org/gnome-team/gnome-control-center/-/raw/ubuntu/master/debian/patches/ubuntu/display-Allow-fractional-scaling-to-be-enabled.patch";
              hash = "sha256-8oZnE8xTs2dPCCK94GJrbA/gv37X5FeR7BvhmycWVWs=";
            })
          ];
        });
      });
    })
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
