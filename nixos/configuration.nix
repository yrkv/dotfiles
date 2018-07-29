# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    imports = [
        ./hardware-configuration.nix
        "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
    ];


    boot.blacklistedKernelModules = [ "nouveau" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.grub.device = "/dev/nvme0n1p10";
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;


    i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "us";
        defaultLocale = "en_US.UTF-8";
    };

    time.timeZone = "America/Los_Angeles";

    environment.variables = { #TODO: difference between this and sessionVariables?
        "gap" = "15";
    };

    environment.pathsToLink = [ "/share/zsh" ];

    environment.systemPackages = with pkgs; [
        htop        polybar     gcc             ncurses     
        cmake       gnumake     pavucontrol     acpi        git
        curl        scrot       binutils        mkpasswd
        xbanish     xst         pciutils        rofi        discord
        xdotool     xdo         ranger          xorg.xrdb   feh

        xtitle
        wmutils-core

        chromium
        steam
        neofetch
        jetbrains.idea-ultimate

        (import ./bspwm-scripts/bspwm-scripts.nix)
    ];

    
    programs = {
        bash.enableCompletion = true;

        chromium = {
            enable = true;
            extensions = [
                "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
                "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
                "clngdbkpkpeebahjckkjfobafhncgmne" # stylus
            ];
            extraOpts = {
                #BlockThirdPartyCookies = true;
                BrowserAddPersonEnabled = false;
                BrowserGuestModeEnabled = false;
                AdsSettingForIntrusiveAdsSites = 2; # block intrusive ads
            };
        };

        command-not-found.enable = true;

        java.enable = true; # defaults to openjdk 8

        light.enable = true;

        tmux = {
            enable = true;
            extraTmuxConf = "set -g mouse on";
            keyMode = "vi";
            shortcut = "a";
            terminal = "st-256color";
        };
    };

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Enable CUPS to print documents.
# services.printing.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = true;

#TODO: bumblebee
# hardware.bumblebee.enable = true;
# hardware.bumblebee.connectDisplay = false;
# hardware.bumblebee.driver = "nouveau"; # nvidia/nouveau


    services = {
        # compton - a simple compositor
        compton = {
            enable = true;

            backend = "xrender"; # options: xrender, glc, xr_glx_hybrid #TODO

            activeOpacity = "1.0";
            inactiveOpacity = "1.0";
            menuOpacity = "1.0";
            opacityRules = [
                "95:class_g = 'st-256color' && focused = 0"
                "100:class_g = 'st-256color' && focused = 1"
                "50:class_g = 'presel_feedback'"
            ];
            
            fade = false;
            # fadeDelta, fadeExclude, fadeSteps

            shadow = false;
            # shadowExclude, shadowOffsets, shadowOpacity

            vSync = "opengl";
        };

        redshift = {
            enable = true;

            # 0.1 - 1.0
            brightness.day = "1.0";
            brightness.night = "0.5";

            # 100 - 25000
            temperature.day = 5500;
            temperature.night = 3400;

            latitude = "47.5303792";
            longitude = "-122.1539042";
        };

        thermald.enable = true;

        # power management service
        tlp.enable = true;

        # hide cursor on keypress
        xbanish.enable = true;

        xserver = {
            enable = true;
            layout = "us";
            xkbOptions = "eurosign:e, caps:escape";
            autoRepeatDelay  = 240;
            autoRepeatInterval = 30;

            libinput = {
                enable = true;
            };

            tty = 6;

            windowManager = {
                default = "bspwm";
                bspwm.enable = true;
            };

            desktopManager.xterm.enable = false;
          #  displayManager.auto = {
          #      enable = true;
          #      user = "yegor";
          #  };
        };
    };


    fonts = {
        enableDefaultFonts = true;
        fonts = with pkgs; [
            corefonts
            terminus_font
            font-awesome-ttf
            font-awesome_4
            font-awesome_5
        ];
    };


    nix = {
        autoOptimiseStore = true;
        
        gc = {
            automatic = true;
            #options = "--delete-older-than 30d";
        };

        optimise = {
            automatic = true;
        };

        maxJobs = 8;
    };

    powerManagement = {
        enable = true;
        powertop.enable = true; # powertop makes boot take way longer
        # scsiLinkPolicy = "min_power"; # tlp sets this already
        # also see services.tlp.enable
    };


    users.defaultUserShell = "/run/current-system/sw/bin/zsh";

    # TODO: setup initial pass (and maybe make non-mutable)
    users.extraUsers.yegor = {
        shell = pkgs.zsh;
        isNormalUser = true;
        home = "/home/yegor";
        initialHashedPassword = 
            "$6$k.yL2A2Jr$bMS9qI5ZrxFgTgUH.mDGRUVabvMfnEKwt7ba461jydhtSEizen.AC4M8yZFMv9jRP9OFYQ1fAhr75nPVkGPg31";
        extraGroups = [ "wheel" "networkmanager" "audio" ];
        uid = 1000;
    };

    home-manager.users.yegor = {
        home.sessionVariables = {
            EDITOR = "vim";
        };

        programs.git = {
            enable = true;
            userName = "yrkv";
            userEmail = "yegor@tydbits.com";
        };

        programs.vim = {
            enable = true;
            plugins = [ "surround" "vim-nix" "vim-airline" ];
            settings = {
                copyindent = true;
                expandtab = true;
                ignorecase = true;
                number = true;
                relativenumber = false;
                shiftwidth = 4;
                smartcase = true;
                tabstop = 4;
            };

            extraConfig = ''
                " reload xrdb on save
                augroup myxrdbhooks
                    au!
                    autocmd bufwritepost .Xresources silent !xrdb ~/.Xresources
                augroup END

                " copy accross vim instance
                vmap <leader>y :w! /tmp/vitmp<CR>
                nmap <leader>p :r! cat /tmp/vitmp<CR>

                " Don't redraw while executing macros
                set lazyredraw

                " map up/down to move visually
                map <Up> gk
                map <Down> gj

                " map <F6> to toggle spell check
                map <F6> :setlocal spell! spelllang=en_us<CR>

                au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

                " keep lines above/below the cursor
                set scrolloff=5
            '';
        };

        programs.zsh = {
            enable = true;
            enableAutosuggestions = true;
            enableCompletion = true;
            dotDir = ".config/zsh";
            history = {
                expireDuplicatesFirst = true;
                ignoreDups = true;
                save = 10000;
                share = true;
                size = 10000;
            };
            plugins = [
                {
                    name = "zsh-history-substring-search";
                    src = pkgs.fetchFromGitHub {
                        owner = "zsh-users";
                        repo = "zsh-history-substring-search";
                        rev = "v1.0.1";
                        sha256 = "0lgmq1xcccnz5cf7vl0r0qj351hwclx9p80cl0qczxry4r2g5qaz";
                    };
                }
                {
                    name = "zsh-syntax-highlighting";
                    src = pkgs.fetchFromGitHub {
                        owner = "zsh-users";
                        repo = "zsh-syntax-highlighting";
                        rev = "v0.6.0";
                        sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
                    };
                }
            ];
            initExtra = ''
                setopt correct extendedglob nocaseglob nobeep autocd

                # Case insensitive tab completion
                zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

                # Colored completion (different colors for dirs/files/etc)
                zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

                # Automatically find new executables in path
                zstyle ':completion:*' rehash true

                # Speed up completions
                zstyle ':completion:*' accept-exact '*(N)'
                zstyle ':completion:*' use-cache on
                zstyle ':completion:*' cache-path ~/.zsh/cache


                # Keybinds section
                bindkey 'OA' history-beginning-search-backward
                bindkey 'OB' history-beginning-search-forward
                bindkey '^[[1;5D' backward-word
                bindkey '^[[1;5C' forward-word
                bindkey '^H' backward-kill-word
                bindkey '^_' history-incremental-search-backward
                bindkey '^[[A' history-substring-search-up			
                bindkey '^[[B' history-substring-search-down

                autoload -U promptinit && promptinit && prompt walters

                # Color man pages
                export LESS_TERMCAP_mb=$'\E[01;32m'
                export LESS_TERMCAP_md=$'\E[01;32m' # this one
                export LESS_TERMCAP_me=$'\E[0m'
                export LESS_TERMCAP_se=$'\E[0m'
                export LESS_TERMCAP_so=$'\E[01;47;34m'
                export LESS_TERMCAP_ue=$'\E[0m'
                export LESS_TERMCAP_us=$'\E[01;36m'
                export LESS=-r

                WORDCHARS=''${WORDCHARS//\/[&.;]}

                source zsh-history-substring-search.zsh
            '';
            shellAliases = {
                l = "ls -alh";
                ll = "ls -l";
                ls = "ls --color=tty";
            };
            
        };
    };

# This value determines the NixOS release with which your system is to be
# compatible, in order to avoid breaking some software such as database
# servers. You should change this only after NixOS release notes say you
# should.
    system.stateVersion = "18.03"; # Did you read the comment?
}
