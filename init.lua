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

require('mini.bufremove').setup()
local MiniClue = require('mini.clue')
MiniClue.setup({
    clues = {
        MiniClue.gen_clues.square_brackets(),
        MiniClue.gen_clues.g(),
        MiniClue.gen_clues.marks(),
        MiniClue.gen_clues.registers(),
        MiniClue.gen_clues.windows(),
        MiniClue.gen_clues.z(),
        { mode = 'n', keys = '<leader>b', desc = '+Buffers' },
        { mode = 'n', keys = '<leader>c', desc = '+Code' },
        { mode = 'n', keys = '<leader>f', desc = '+Picker' },
        { mode = 'n', keys = '<leader>g', desc = '+Git' },
        { mode = 'n', keys = '<leader>q', desc = '+Session' },
    },
    triggers = {
        { mode = { 'n', 'x' }, keys = '<Leader>' },
        { mode = 'n',          keys = '[' },
        { mode = 'n',          keys = ']' },
        { mode = { 'n', 'x' }, keys = 'g' },
        { mode = { 'n', 'x' }, keys = '`' },
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },
        { mode = 'n',          keys = '<C-w>' },
        { mode = { 'n', 'x' }, keys = 'z' },
    },
    window = { delay = 200 },
})
require('mini.cmdline').setup()
require('mini.completion').setup()
require('mini.diff').setup()
require('mini.files').setup({
    content = {
        filter = function(fs_entry)
            return not vim.startswith(fs_entry.name, '.')
        end
    }
})
require('mini.git').setup()
require('mini.icons').setup()
require('mini.move').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.snippets').setup()
require('mini.splitjoin').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.surround').setup()

local languages = {
    { parser = 'bash',           filetypes = { 'sh' },              lsp = 'bashls' },
    { parser = 'c',              filetypes = { 'c' },               lsp = 'clangd' },
    { parser = 'cpp',            filetypes = { 'cpp' },             lsp = 'clangd' },
    { parser = 'css',            filetypes = { 'css' },             lsp = 'cssls' },
    { parser = 'diff' },
    { parser = 'git_rebase' },
    { parser = 'gitcommit' },
    { parser = 'go',             filetypes = { 'go' },              lsp = 'gopls' },
    { parser = 'html',           filetypes = { 'html' },            lsp = 'html' },
    { parser = 'java',           filetypes = { 'java' },            lsp = 'jdtls' },
    { parser = 'javascript',     filetypes = { 'javascriptreact' }, lsp = 'tsc' },
    { parser = 'json',           filetypes = { 'json' },            lsp = 'jsonls' },
    { parser = 'lua',            filetypes = { 'lua' },             lsp = 'lua_ls' },
    { parser = 'markdown',       filetypes = { 'markdown' },        lsp = 'marksman' },
    { parser = 'markdown_inline' },
    { parser = 'python',         filetypes = { 'python' },          lsp = 'basedpyright' },
    { parser = 'rust',           filetypes = { 'rust' },            lsp = 'rust_analyzer' },
    { parser = 'tsx',            filetypes = { 'typescriptreact' }, lsp = 'tsc' },
    { parser = 'typescript',     filetypes = { 'typescript' },      lsp = 'tsc' },
    { parser = 'vim',            filetypes = { 'vim' },             lsp = 'vimls' },
    { parser = 'vimdoc',         filetypes = { 'vimdoc' } },
    { parser = 'yaml',           filetypes = { 'yaml' },            lsp = 'yamlls' },
}

local parsers, filetypes, servers = {}, {}, {}
for _, lang in ipairs(languages) do
    if lang.parser then
        table.insert(parsers, lang.parser)
    end

    for _, ft in ipairs(lang.filetypes or {}) do
        table.insert(filetypes, ft)
    end

    if lang.lsp then
        servers[lang.lsp] = true
    end
end

require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function() vim.treesitter.start() end,
})

vim.lsp.enable(vim.tbl_keys(servers))

vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--header-insertion=iwyu',
    },
})

require('options')
require('keymaps')
require('commands')
