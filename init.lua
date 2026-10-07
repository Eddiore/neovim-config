local vim = vim
vim.g.mapleader = ' '

vim.pack.add({
    {
        src = 'https://github.com/catppuccin/nvim',
        name = 'catppuccin'
    },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

vim.cmd.colorscheme('catppuccin-nvim')

require('vim._core.ui2').enable()

require('mini.clue').setup({
    clues = {
        { mode = 'n', keys = '<leader>b',  desc = '+Buffers' },
        { mode = 'n', keys = '<leader>c',  desc = '+Code' },
        { mode = 'n', keys = '<leader>f',  desc = '+Files' },
        { mode = 'n', keys = '<leader>g',  desc = '+Git' },
        { mode = 'n', keys = '<leader>gh', desc = '+Git hunks' },
        { mode = 'n', keys = '<leader>q',  desc = '+Session' },
        { mode = 'n', keys = '<leader>s',  desc = '+Search' },
        { mode = 'n', keys = '<leader>u',  desc = '+UI' },
        { mode = 'n', keys = '<leader>w',  desc = '+Window' },
    },
    triggers = {
        { mode = { 'n', 'x' }, keys = '<Leader>' },
        { mode = 'n',          keys = '[' },
        { mode = 'n',          keys = ']' },
        { mode = 'i',          keys = '<C-x>' },
        { mode = { 'n', 'x' }, keys = 'g' },
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },
        { mode = 'n',          keys = '<C-w>' },
        { mode = { 'n', 'x' }, keys = 'z' },
    },
    window = { delay = 100 },
})
require('mini.cmdline').setup()
require('mini.completion').setup()
require('mini.diff').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.snippets').setup()
require('mini.starter').setup()
require('mini.surround').setup()

local TreeSitter = require('nvim-treesitter')
TreeSitter.install({
    'bash',
    'c',
    'c_sharp',
    'cpp',
    'css',
    'diff',
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'go',
    'html',
    'java',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'rust',
    'vim',
    'vimdoc',
    'yaml',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'c', 'cpp', 'cs', 'cshtml', 'css', 'html', 'json', 'md', 'py', 'rs', 'yaml' },
    callback = function() vim.treesitter.start() end,
})

vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--header-insertion=iwyu',
    },
})

vim.lsp.enable({
    'basedpyright',
    'bashls',
    'clangd',
    'cssls',
    'gopls',
    'html',
    'jdtls',
    'jsonls',
    'lua_ls',
    'marksman',
    'roslyn_ls',
    'rust_analyzer',
    'vimls',
    'yamlls',
})

require('options')
require('keymaps')
