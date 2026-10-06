local opt = vim.opt

--- ui/ux ---
opt.background = 'dark'
opt.colorcolumn = '100'
opt.cursorline = true
opt.errorbells = false
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
opt.foldmethod = 'expr'
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.termguicolors = true

--- formatting ---
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4

--- search ---
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

--- files ---
opt.autochdir = false
opt.autoread = true
opt.autowrite = false
opt.autowriteall = false
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.updatetime = 250

--- editing ---
opt.backspace = 'indent,eol,start'
opt.completeopt = { 'menuone', 'noselect', 'popup' }
