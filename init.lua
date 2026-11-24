local vim = vim
local opt = vim.opt

vim.g.mapleader = ' '

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


--- packages ---
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

MiniBufRemove.setup()
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
MiniCmdLine.setup()
MiniCompletion.setup()
MiniDiff.setup()
MiniFiles.setup({
    content = {
        filter = function(fs_entry)
            return not vim.startswith(fs_entry.name, '.')
        end
    }
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


--- LSP ---
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
        '--compile-commands-dir=build',
        '--header-insertion=iwyu',
    },
})


--- keymaps ---
local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>R', '<Cmd>restart<CR>', { desc = 'Restart Neovim' })
map('n', '<leader>qq', '<Cmd>quit<CR>', { desc = 'Quit Session' })

map('n', '<leader>bo', function()
    local current = vim.api.nvim_get_current_buf()

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype ~= 'terminal' then
            if bufnr ~= current and not vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
                vim.api.nvim_buf_delete(bufnr, { force = false })
            end
        end
    end
end, { desc = 'Delete other buffers' })

map('v', '<leader>S', ':sort!<CR>', { desc = 'Reverse sort selection' })
map('v', '<leader>s', ':sort<CR>', { desc = 'Sort selection' })

map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal' })
map('n', '<leader>t', function()
    if TERMINAL_BUF and vim.api.nvim_buf_is_valid(TERMINAL_BUF) then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == TERMINAL_BUF then
                vim.api.nvim_win_close(win, true)
                return
            end
        end

        vim.cmd('botright 15split')
        vim.api.nvim_win_set_buf(0, TERMINAL_BUF)
        vim.cmd('startinsert')
        return
    end

    vim.cmd('botright 15split | terminal')
    TERMINAL_BUF = vim.api.nvim_get_current_buf()
    vim.cmd('startinsert')
end, { desc = 'Toggle terminal' })

map('n', '<leader>bd', function() MiniBufRemove.delete() end, { desc = 'Close buffer' })

map('n', '<leader>go', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })

map('n', '<leader>E', function() MiniFiles.open(nil, false) end, { desc = 'Open file explorer' })
map('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open last file explorer' })
map('n', '<leader>be', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open file explorer at buffer' })

map('n', '<leader>bg', '<Cmd>write | Git add -- %<CR>', { desc = 'Write buffer and stage' })
map('n', '<leader>gR', '<Cmd>Git restore -- %<CR>', { desc = 'Git restore current file' })
map('n', '<leader>ga', '<Cmd>Git add -- %<CR>', { desc = 'Git add current file' })
map('n', '<leader>gd', '<Cmd>Git diff HEAD -- %<CR>', { desc = 'Git diff current file' })
map('n', '<leader>gr', '<Cmd>Git restore --staged %<CR>', { desc = 'Git unstage current file' })

map('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
map('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
map('n', '<leader>fg', function() MiniPick.builtin.grep_live() end, { desc = 'Search live grep' })
map('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
map('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'Resume picker' })

map('n', '<leader>qc', function()
    vim.ui.input({
        prompt = 'Session name: ',
    }, function(name)
        if name and name ~= '' then
            MiniSessions.write(name)
        end
    end)
end, { desc = 'Create session' })
map('n', '<leader>qd', function() MiniSessions.select('delete') end, { desc = 'Delete session' })
map('n', '<leader>qs', function() MiniSessions.select('read') end, { desc = 'Load session' })
map('n', '<leader>qw', function() MiniSessions.select('write') end, { desc = 'Write session' })

vim.api.nvim_create_autocmd('LspAttach', {
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
        lsp_map('n', '<leader>ch', '<Cmd>LspClangdSwitchSourceHeader<CR>', 'Switch header/source')
        lsp_map('n', '<leader>ci', toggle_inlay, 'Toggle inlay hints')
        lsp_map('n', '<leader>cl', '<Cmd>lsp restart<CR>', 'Restart LSP')
        lsp_map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
        lsp_map('n', '<leader>cs', vim.lsp.buf.document_symbol, 'Symbol list')
        lsp_map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        lsp_map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        lsp_map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    end,
})


--- commands ---
local create_autocmd = vim.api.nvim_create_autocmd

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

local filter_show = function(fs_entry) return true end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
end

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

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set('n', 'gh', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
        vim.keymap.set('n', 'gx', ui_open, { buffer = buf_id, desc = 'OS open' })
        vim.keymap.set('n', 'gy', yank_path, { buffer = buf_id, desc = 'Yank path' })
    end,
})
