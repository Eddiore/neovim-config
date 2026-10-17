local opt = vim.opt

--- behavior ---
opt.clipboard = 'unnamedplus'
opt.errorbells = false
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
opt.foldmethod = 'expr'
opt.iskeyword:append('-')
opt.mouse = 'a'

--- editing ---
opt.backspace = 'indent,eol,start'
opt.completeopt = { 'menuone', 'noselect', 'popup' }

--- files ---
opt.autochdir = false
opt.autoread = true
opt.autowrite = false
opt.autowriteall = false
opt.swapfile = false
opt.updatetime = 250

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

--- visual ---
opt.background = 'dark'
opt.colorcolumn = '100'
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.wrap = false
