# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Requirements

### Base

- Debian

```bash
sudo apt install clang clang-format fd-find fzf git kitty luarocks neovim nodejs wget
```

- Fedora

```bash
sudo dnf install clang clang-tools-extra fd fzf git kitty luarocks nodejs nvim wget
```

- macOS (Homebrew)

```bash
brew install fd fzf git luarocks neovim node wget
```

### Extras

- lazygit
- tmux
- Fira Code ([Nerd Font](https://www.nerdfonts.com/font-downloads))

## Installation

Run the following command to clone this repository:

```bash
git clone https://github.com/Eddiore/neovim-config.git ~/.config/nvim/
```

## Guide

### Lazygit

- Follow the instructions for your OS at [Lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation).

### Tmux

1. Install `tmux` using your distro's package manager:
2. Go to [TPM](https://github.com/tmux-plugins/tpm) and follow the instructions.
3. Paste the following into ```~/.tmux.conf```:

```bash
set -g default-terminal 'screen-256color'
set -g mouse on

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

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

4. Open `tmux` inside a terminal and press `Ctrl+b+I`.

### Nerd Fonts

1. Download a font from [Nerd Font](https://www.nerdfonts.com/font-downloads).
2. Extract the zip file.
3. Install fonts according to your OS.
