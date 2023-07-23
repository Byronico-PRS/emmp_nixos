# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
          
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "paulo_dell"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Enable flatpak
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm = {
    enable = true;
    background = "/home/emmp/Imagens/emmp_bgs/01.jpg";
    greeters.gtk = {
      enable = true;
      iconTheme.package = pkgs.maia-icon-theme;
      iconTheme.name = "Maia-dark"; 
      theme.package = pkgs.zuki-themes;
      theme.name = "Zukitwo-dark";
      extraConfig = "user-background = false";
      };

  };

   services.xserver.desktopManager = { 
    xfce.enable = true;
    wallpaper.mode = "scale";
  };
  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    defaultShared = true;
    browsing = true;
  };
  # Enable browse print
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  programs.system-config-printer.enable = true;

  # Enable ntfs file system (to open pen drives in ntfs)
  boot.supportedFilesystems = [ "ntfs" ];

  # Disable pipewire. enable jack pulse and alsa
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
};

  services.jack = {
    jackd.enable = false;
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = false;
    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
     # dmixConfig = ''
     #   period_size 256
     #         '';
    };
  };

  hardware.pulseaudio.package = pkgs.pulseaudio.override { jackaudioSupport = true; };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    
  users.users.emmp = {
    isNormalUser = true;
    description = "emmp";
    homeMode = "755";
    extraGroups = [ "networkmanager" "wheel" "audio" "jackaudio" ];
    packages = with pkgs; [

       #games
       scid #chessdatabase
       ltris #tetris
       abuse #sidescroller action game
       xonotic #multiplayer fps
       stockfish #chess engine   
       ]; 
   };
  
  users.extraUsers.professores = {
    isNormalUser = true;
    description = "professores";
    home = "/home/professores";
    extraGroups = [ "networkmanager" "wheel" "audio" "jackaudio"];
    password = "Prof1213";
    };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  
  # Xfce Apps
  pavucontrol #mixer audio program
  xfce.xfce4-pulseaudio-plugin #applet that fits in xfce theme that control pavucontrol
  xfce.catfish
  xfce.xfce4-whiskermenu-plugin 
  xfce.xfce4-clipman-plugin   
  xfce.thunar-archive-plugin  
 # lightdm_gtk_greeter    
  gparted
  libsForQt5.breeze-icons
  zafiro-icons
  xarchiver
  # terminal apps
  wget
  xz
  gzip
  vim
  htop
  btop
  neofetch
  ffmpeg
  unzip
  p7zip
  maia-icon-theme
  gparted
  libsForQt5.breeze-icons
  zafiro-icons
  libsForQt5.kdeconnect-kde    
 # libsForQt5.bismuth
  fluidsynth
  alsaTools
  jack2
  cadence
  pulseaudioFull
  soundfont-fluid
  soundfont-ydp-grand

  #Internet
  firefox #browser
  brave #browser
  thunderbird #mail-client

  # Escritorio
  libreoffice #office suite
  okular #pdf reade
  vscodium #text editor
  direnv
  git
  unetbootin #live usb creator
  nextcloud-client #cloud files
 
  # Audio
  musescore #editor de partitura
  reaper #daw essa versao provoca dificuldades de configuração com o reapck e outros plugins do js
  ardour #daw
  helm #synth
  distrho #pugin suite
  drumgizmo #drum sample
  vmpk    #piano
  guitarix # guitar amps
  gxplugins-lv2 #guitar plugin
  calf #plugin suite

  # Video
  obs-studio #rec_screen vide_studio
  vlc #video player
  libsForQt5.kdenlive #video editor
  gphoto2 #cam tool
     
  #Windows apps
  wineWowPackages.waylandFull
  winetricks
  carla
  yabridge
  yabridgectl
  ffmpeg_5-full

  #imagens
  gimp
  inkscape 
            
  ];


  # Make some extra kernel modules available to NixOS (configuracao para camera DSRL, importante q tenho ffmpg já instalado)
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];

  # Activate kernel modules (choose from built-ins and extra ones)
  boot.kernelModules = [
    # Virtual Camera
    "v4l2loopback"
  
  ];


  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 max_buffers=2 card_label="Canon"
  '';

  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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
  system.stateVersion = "23.05"; # Did you read the comment?

}
