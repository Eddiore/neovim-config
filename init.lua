local vim = vim
local map = vim.keymap.set
local create_autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = ' '

vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '100'
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.wrap = false

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

local MiniBracketed = require('mini.bracketed')
local MiniBufRemove = require('mini.bufremove')
local MiniClue = require('mini.clue')
local MiniCmdLine = require('mini.cmdline')
local MiniCompletion = require('mini.completion')
local MiniDiff = require('mini.diff')
local MiniFiles = require('mini.files')
local MiniGit = require('mini.git')
local MiniIcons = require('mini.icons')
local MiniMove = require('mini.move')
local MiniPairs = require('mini.pairs')
local MiniPick = require('mini.pick')
local MiniSessions = require('mini.sessions')
local MiniSnippets = require('mini.snippets')
local MiniSplitJoin = require('mini.splitjoin')
local MiniStatusLine = require('mini.statusline')
local MiniSurround = require('mini.surround')

local NvimTreesitter = require('nvim-treesitter')

local filter_show = function(fs_entry) return true end
local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end

local current_buffer_name = function() return vim.api.nvim_buf_get_name(0) end

MiniBracketed.setup()
MiniBufRemove.setup()
MiniClue.setup({
    clues = {
        MiniClue.gen_clues.square_brackets(),
        MiniClue.gen_clues.g(),
        MiniClue.gen_clues.marks(),
        MiniClue.gen_clues.registers(),
        MiniClue.gen_clues.windows(),
        MiniClue.gen_clues.z(),
        { mode = 'n', keys = '<leader>c', desc = '+Code' },
        { mode = 'n', keys = '<leader>f', desc = '+Picker' },
        { mode = 'n', keys = '<leader>g', desc = '+Git' },
        { mode = 'n', keys = '<leader>s', desc = '+Session' },
    },
    triggers = {
        { mode = { 'n', 'x' }, keys = '<leader>' },
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
MiniCmdLine.setup()
MiniCompletion.setup()
MiniDiff.setup()
MiniFiles.setup({
    content = { filter = filter_hide }
})
MiniGit.setup()
MiniIcons.setup()
MiniMove.setup()
MiniPairs.setup()
MiniPick.setup()
MiniSessions.setup()
MiniSnippets.setup()
MiniSplitJoin.setup()
MiniStatusLine.setup()
MiniSurround.setup()

local languages = {
    { parser = 'bash',           filetype = 'sh',       lsp = 'bashls' },
    { parser = 'c',              filetype = 'c',        lsp = 'clangd' },
    { parser = 'cpp',            filetype = 'cpp',      lsp = 'clangd' },
    { parser = 'css',            filetype = 'css',      lsp = 'cssls' },
    { parser = 'diff' },
    { parser = 'git_rebase' },
    { parser = 'gitcommit' },
    { parser = 'go',             filetype = 'go',       lsp = 'gopls' },
    { parser = 'html',           filetype = 'html',     lsp = 'html' },
    { parser = 'java',           filetype = 'java',     lsp = 'jdtls' },
    { parser = 'json',           filetype = 'json',     lsp = 'jsonls' },
    { parser = 'lua',            filetype = 'lua',      lsp = 'lua_ls' },
    { parser = 'markdown',       filetype = 'markdown', lsp = 'marksman' },
    { parser = 'markdown_inline' },
    { parser = 'python',         filetype = 'python',   lsp = 'basedpyright' },
    { parser = 'rust',           filetype = 'rust',     lsp = 'rust_analyzer' },
    { parser = 'vim',            filetype = 'vim',      lsp = 'vimls' },
    { parser = 'vimdoc',         filetype = 'vimdoc' },
    { parser = 'yaml',           filetype = 'yaml',     lsp = 'yamlls' },
}

local parsers, filetypes, servers = {}, {}, {}
for _, lang in ipairs(languages) do
    if lang.parser then
        parsers[lang.parser] = true
    end

    if lang.filetype then
        filetypes[lang.filetype] = true
    end

    if lang.lsp then
        servers[lang.lsp] = true
    end
end

NvimTreesitter.install(vim.tbl_keys(parsers))

create_autocmd('FileType', {
    pattern = vim.tbl_keys(filetypes),
    callback = function() vim.treesitter.start() end,
})

vim.lsp.enable(vim.tbl_keys(servers))

map('n', '<Esc>', ':nohlsearch<CR>')
map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal' })
map('v', '<leader>S', ':sort!<CR>', { desc = 'Reverse sort selection' })
map('v', '<leader>s', ':sort<CR>', { desc = 'Sort selection' })

map('n', '<leader>B', function() MiniFiles.open(current_buffer_name()) end, { desc = 'Open file system (buffer)' })
map('n', '<leader>D', function() MiniBufRemove.delete() end, { desc = 'Delete buffer' })
map('n', '<leader>E', function() MiniFiles.open(nil, false) end, { desc = 'Open file system' })
map('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open file system (last)' })
map('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
map('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
map('n', '<leader>fg', function() MiniPick.builtin.grep_live() end, { desc = 'Search live grep' })
map('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
map('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'Resume picker' })
map('n', '<leader>ga', ':Git add -- %<CR>', { desc = 'Git add current file' })
map('n', '<leader>gd', ':Git diff HEAD -- %<CR>', { desc = 'Git diff current file' })
map('n', '<leader>go', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })
map('n', '<leader>gr', ':Git restore -- %<CR>', { desc = 'Git restore current file' })
map('n', '<leader>gu', ':Git restore --staged %<CR>', { desc = 'Git unstage current file' })
map('n', '<leader>sd', function() MiniSessions.select('delete') end, { desc = 'Delete session' })
map('n', '<leader>sl', function() MiniSessions.select('read') end, { desc = 'Load session' })
map('n', '<leader>sw', function() MiniSessions.select('write') end, { desc = 'Write session' })

create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        local toggle_inlay = function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end

        local function lsp_map(mode, lhs, rhs, desc)
            map(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
        end

        lsp_map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        lsp_map('n', '<leader>cd', vim.diagnostic.open_float, 'Show diagnostics window')
        lsp_map('n', '<leader>cf', vim.lsp.buf.format, 'Format File')
        lsp_map('n', '<leader>ch', ':LspClangdSwitchSourceHeader<CR>', 'Switch header/source')
        lsp_map('n', '<leader>ci', toggle_inlay, 'Toggle inlay hints')
        lsp_map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
        lsp_map('n', '<leader>cs', vim.lsp.buf.document_symbol, 'Symbol list')
        lsp_map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        lsp_map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        lsp_map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    end,
})

create_autocmd('QuitPre', {
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buftype == 'terminal' then
                pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
        end
    end,
})

local show_dotfiles = false

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end

local yank_path = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify('Cursor is not on valid entry') end
    vim.fn.setreg(vim.v.register, path)
end

local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id
        map('n', 'gh', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
        map('n', 'gx', ui_open, { buffer = buf_id, desc = 'OS open' })
        map('n', 'gy', yank_path, { buffer = buf_id, desc = 'Yank path' })
    end,
})
