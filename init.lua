vim.g.mapleader = ' '

--- options ---
local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.updatetime = 250
opt.swapfile = false
opt.clipboard = 'unnamedplus'

opt.completeopt = { 'menuone', 'noselect', 'popup' }

vim.pack.add {
    { src = 'https://github.com/catppuccin/nvim',                name = 'catppuccin' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },
}


--- theme ---
vim.cmd.colorscheme 'catppuccin-mocha'


--- mini.cmdline ---
local MiniCmd = require('mini.cmdline')
MiniCmd.setup()


--- mini.completion ---
local MiniCompletion = require('mini.completion')
MiniCompletion.setup()

vim.keymap.set('i', '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-y>'
    end

    return '<Tab>'
end, { expr = true, replace_keycodes = true })


--- mini.diff ---
local MiniDiff = require('mini.diff')
MiniDiff.setup()

vim.keymap.set('n', '<leader>go', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })
vim.keymap.set('n', '<leader>ghs', function() MiniDiff.do_hunk(0, 'apply') end, { desc = 'Stage hunk' })
vim.keymap.set('n', '<leader>ghr', function() MiniDiff.do_hunk(0, 'reset') end, { desc = 'Reset hunk' })


--- mini.files ---
local MiniFiles = require('mini.files')
MiniFiles.setup()

vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open file explorer (last session)' })
vim.keymap.set('n', '<leader>E', function() MiniFiles.open(nil, false) end, { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>be', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open file explorer at current buffer' })


--- mini.git ---
local MiniGit = require('mini.git')
MiniGit.setup()

vim.keymap.set('n', '<leader>ga', '<Cmd>Git add -- %<CR>', { desc = 'Git add current file' })
vim.keymap.set('n', '<leader>gA', '<Cmd>Git add .<CR>', { desc = 'Git add all files' })
vim.keymap.set('n', '<leader>gc', '<Cmd>Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gf', '<Cmd>Git fetch<CR>', { desc = 'Git fetch' })
vim.keymap.set('n', '<leader>gp', '<Cmd>Git pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>gP', '<Cmd>Git push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gd', '<Cmd>Git diff HEAD -- %<CR>', { desc = 'Git diff current file' })
vim.keymap.set('n', '<leader>gD', '<Cmd>Git diff HEAD<CR>', { desc = 'Git diff' })
vim.keymap.set('n', '<leader>gH', function() MiniGit.show_at_cursor() end, { desc = 'Git history at cursor' })
vim.keymap.set('n', '<leader>gr', '<Cmd>Git restore --staged %<CR>', { desc = 'Git unstage current file' })
vim.keymap.set('n', '<leader>gR', '<Cmd>Git restore -- %<CR>', { desc = 'Git restore current file' })
vim.keymap.set('n', '<leader>gs', '<Cmd>Git status<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gS', function() MiniGit.show_diff_source() end, { desc = 'Git diff source' })
vim.keymap.set('n', '<leader>gu', '<Cmd>Git reset --soft HEAD~1<CR>', { desc = 'Git undo last commit' })


--- mini.icons ---
local MiniIcons = require('mini.icons')
MiniIcons.setup()


--- mini.notify ---
local MiniNotify = require('mini.notify')
MiniNotify.setup()


--- mini.pick ---
local MiniPick = require('mini.pick')
MiniPick.setup()

vim.keymap.set('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'Resume picker' })
vim.keymap.set('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
vim.keymap.set('n', '<leader>bb', function() MiniPick.builtin.buffers() end, { desc = 'Pick buffer' })
vim.keymap.set('n', '<leader>sg', function() MiniPick.builtin.grep_live() end, { desc = 'Search live grep' })


--- mini.sessions ---
local MiniSessions = require('mini.sessions')
MiniSessions.setup()

vim.keymap.set('n', '<leader>qs', function() MiniSessions.select('read') end, { desc = 'Load session' })
vim.keymap.set('n', '<leader>qc', function()
    vim.ui.input({
        prompt = 'Session name: ',
        default = default,
    }, function(name)
        if name and name ~= '' then
            MiniSessions.write(name)
        end
    end)
end, { desc = 'Create session' })
vim.keymap.set('n', '<leader>qw', function() MiniSessions.select('write') end, { desc = 'Write session' })
vim.keymap.set('n', '<leader>qd', function() MiniSessions.select('delete') end, { desc = 'Delete session' })


--- mini.snippets ---
local MiniSnippets = require('mini.snippets')
MiniSnippets.setup()


--- mini.starter ---
local MiniStarter = require('mini.starter')
MiniStarter.setup()


--- mini.surround ---
local MiniSurround = require('mini.surround')
MiniSurround.setup()


--- which-key ---
local WhichKey = require('which-key')
WhichKey.setup({
    preset = 'helix',
})

WhichKey.add({
    { '<leader>b',  group = '+Buffers' },
    { '<leader>c',  group = '+Code' },
    { '<leader>f',  group = '+Files' },
    { '<leader>g',  group = '+Git' },
    { '<leader>gh', group = '+Hunks' },
    { '<leader>q',  group = '+Session' },
    { '<leader>s',  group = '+Search' },
    { '<leader>u',  group = '+UI' },
    { '<leader>w',  group = '+Window' },
})


--- nvim-treesitter ---
local TreeSitter = require('nvim-treesitter')
TreeSitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site'
})

TreeSitter.install({
    'bash',
    'c',
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
    pattern = { 'lua', 'c', 'cpp' },
    callback = function() vim.treesitter.start() end,
})


--- LSP ---
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--header-insertion=iwyu',
    },
})

vim.lsp.enable({
    'bashls',
    'clangd',
    'cssls',
    'gopls',
    'html',
    'jdtls',
    'jsonls',
    'lua_ls',
    'marksman',
    'basedpyright',
    'rust_analyzer',
    'vimls',
    'yamlls',
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = 'Go to definition' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts, { desc = 'Go to references' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts, { desc = 'Go to declaration' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts, { desc = 'Go to implementation' })

        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts, { desc = 'Rename symbol' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts, { desc = 'Code action' })

        vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, opts, { desc = 'Show diagnostics window' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts, { desc = 'Go to prev diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts, { desc = 'Go to next diagnostic' })
    end,
})


--- Keymappings ---
vim.keymap.set('n', '<C-s>', '<Cmd>write<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>qq', '<Cmd>quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>qQ', '<Cmd>!quit<CR>', { desc = 'Force Quit' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format File' })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bp', '<Cmd>bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bn', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bo', '<Cmd>bd|e#|bd#<CR>', { desc = 'Delete other buffers' })
vim.keymap.set('n', '<leader>by', '<Cmd>%y+<CR>', { desc = 'Yank buffer' })
vim.keymap.set('n', '<leader><Tab>', '<Cmd>b#<CR>', { desc = 'Alternate buffer' })

vim.keymap.set('n', '<leader>t', function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)

        if vim.bo[buf].buftype == 'terminal' then
            vim.api.nvim_set_current_win(win)
            vim.cmd('bd!')
            return
        end
    end

    vim.cmd('botright 15split | terminal')
end, { desc = 'Toggle terminal' })

vim.keymap.set("n", "<leader>uh", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end, { desc = "Toggle inlay hints" })

vim.keymap.set('n', '<leader>ul', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Toggle relative line numbers' })

vim.keymap.set('n', '<leader>wv', '<Cmd>vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>wh', '<Cmd>split<CR>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Go to right window' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Equalize window' })
vim.keymap.set('n', '<leader>wd', '<Cmd>close<CR>', { desc = 'Close window' })

vim.keymap.set('n', '<leader>sr', function()
    vim.ui.input({ prompt = 'Search: ' }, function(find)
        if not find or find == '' then
            return
        end

        vim.ui.input({ prompt = 'Replace: ' }, function(replace)
            if not replace then
                return
            end
            vim.cmd(string.format('%%s/%s/%s/g', vim.fn.escape(find, '/'), vim.fn.escape(replace, '/')))
        end)
    end)
end, { desc = 'Search and replace' })
vim.keymap.set('n', '<leader>sR', function()
    vim.ui.input({ prompt = 'Search: ' }, function(find)
        if not find or find == '' then
            return
        end

        vim.ui.input({ prompt = 'Replace: ' }, function(replace)
            if not replace then
                return
            end
            vim.cmd(string.format('%%s/%s/%s/gc', vim.fn.escape(find, '/'), vim.fn.escape(replace, '/')))
        end)
    end)
end, { desc = 'Search and replace (confirm)' })
