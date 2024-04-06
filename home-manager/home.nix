{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  dircolorsSettings = import ./dircolors.nix;
in
{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    #unstable.discord-screenaudio
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  home.sessionVariables = {
    EDITOR = "/usr/bin/env nvim";
    VISUAL = "/usr/bin/env nvim";
  };

  home.shellAliases = {
    nv = "nvim -p";
  };

  fonts.fontconfig.enable = true;

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "john@jwhiting.dev";
      userName = "John Whiting";
      extraConfig = {
        commit.gpgsign = true;
	gpg.format = "ssh";
	user.signingkey = "$HOME/.ssh/git_id_ed25519.pub";
      };
    };
    ripgrep.enable = true;
    zellij = {
      enable = true;
      settings = {
        default_shell = "zsh";
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
	bindkey -e
	
	# CTRL + backspace and CTRL + delete
	bindkey '^H' backward-kill-word
	bindkey '^[[3;5~' kill-word
	
	# CTRL + Arrow Left/Right
	bindkey "^[[1;5C" forward-word
	bindkey "^[[1;5D" backward-word

	# Home and End
	bindkey '^[OH' beginning-of-line
	bindkey '^[OF' end-of-line
      '';
      prezto = {
        enable = true;
	caseSensitive = false;
	prompt.theme = "steeef";
      };
    };
    dircolors = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = dircolorsSettings;
    };
  };
}
