# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Requirements
### Linux
- clangd
- wget
- bear
- fd
- fzf
- lazygit
- luarocks
- kitty

### Extras
- tmux
- Fira Code ([Nerd Font](https://www.nerdfonts.com/font-downloads))

# Guide
## Linux
### Tmux
1. Install `tmux` using the distro's package manager.
2. Go to [TPM](https://github.com/tmux-plugins/tpm) and follow the instructions.
3. Paste the following into `~/.tmux.conf`:
```
set -g default-terminal 'screen-256color'

# Enable vim keybindings
setw -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+

set -g prefix2 C-space

unbind r
bind r source-file ~/.tmux.conf

# Pick a softer palette.
set -g @catppuccin_flavor 'mocha'

# Make the status line more pleasant.
set -g status-left ""
set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '

# Ensure that everything on the right side of the status line
# is included.
set -g status-right-length 100

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'alexwforsythe/tmux-which-key'
set -g @plugin 'catppuccin/tmux#v2.1.3'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```
4. Open `tmux` inside a terminal and press `Ctrl+b+I`.

### Nerd Fonts
1. Download a font from [Nerd Font](https://www.nerdfonts.com/font-downloads).
2. Extract the zip file.
3. Copy/Move the extracted folder to `~/.local/share/fonts/`.
4. Inside kitty, run `kitten choose-fonts`.
5. Select the downloaded font and follow the instructions.
