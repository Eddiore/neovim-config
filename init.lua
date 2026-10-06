local vim = vim
vim.g.mapleader = ' '

vim.pack.add({
    {
        src = 'https://github.com/catppuccin/nvim',
        name = 'catppuccin'
    },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },
})

vim.cmd.colorscheme('catppuccin-nvim')

require('mini.cmdline').setup()
require('mini.completion').setup()
require('mini.diff').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.notify').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.snippets').setup()
require('mini.starter').setup()
require('mini.surround').setup()

local WhichKey = require('which-key')
WhichKey.setup({
    preset = 'helix',
})
WhichKey.add({
    { '<leader>b',  group = '+Buffers' },
    { '<leader>c',  group = '+Code' },
    { '<leader>f',  group = '+Files' },
    { '<leader>g',  group = '+Git' },
    { '<leader>gh', group = '+Git hunks' },
    { '<leader>q',  group = '+Session' },
    { '<leader>s',  group = '+Search' },
    { '<leader>u',  group = '+UI' },
    { '<leader>w',  group = '+Window' },
})

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
    'roslyn',
    'rust_analyzer',
    'vimls',
    'yamlls',
})

require('options')
require('keymaps')
