local vim = vim
local map = vim.keymap.set

--- general ---
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map('n', '<leader>qq', '<Cmd>quit<CR>', { desc = 'Quit' })
map('n', '<leader>qQ', '<Cmd>!quit<CR>', { desc = 'Force Quit' })
map('n', '<leader>qr', '<Cmd>restart<CR>', { desc = 'Restart Neovim' })

--- buffers ---
map('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bm', '<Cmd>bmodified<CR>', { desc = 'Next modified buffer' })
map('n', '<leader>bn', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bo', '<Cmd>bd|e#|bd#<CR>', { desc = 'Delete other buffers' })
map('n', '<leader>bp', '<Cmd>bprev<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bw', '<Cmd>write<CR>', { desc = 'Write buffer' })
map('n', '<leader>by', '<Cmd>%y+<CR>', { desc = 'Yank buffer' })
map('n', '<leader><Tab>', '<Cmd>b#<CR>', { desc = 'Alternate buffer' })

--- terminal ---
map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal' })
map({ 'n', 't' }, '<leader>t', function()
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

--- ui ---
map("n", "<leader>uh", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end, { desc = "Toggle inlay hints" })

map('n', '<leader>ul', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Toggle relative line numbers' })

--- windows ---
map('n', '<leader>wv', '<Cmd>vsplit<CR>', { desc = 'Split vertically' })
map('n', '<leader>wh', '<Cmd>split<CR>', { desc = 'Split horizontally' })
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
map('n', '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
map('n', '<leader>wj', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<leader>wk', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<leader>wl', '<C-w>l', { desc = 'Go to right window' })
map('n', '<leader>we', '<C-w>=', { desc = 'Equalize window' })
map('n', '<leader>wd', '<Cmd>close<CR>', { desc = 'Close window' })

--- search ---
map('n', '<leader>sr', function() vim.api.nvim_feedkeys(':%s/', 'n', false) end, { desc = 'Search and replace' })


--- mini.diff ---
local MiniDiff = require('mini.diff')
map('n', '<leader>ug', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })
map('n', '<leader>ghs', function() MiniDiff.do_hunk(0, 'apply') end, { desc = 'Stage hunk' })
map('n', '<leader>ghr', function() MiniDiff.do_hunk(0, 'reset') end, { desc = 'Reset hunk' })

--- mini.files ---
local MiniFiles = require('mini.files')
map('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open file explorer (last session)' })
map('n', '<leader>E', function() MiniFiles.open(nil, false) end, { desc = 'Open file explorer' })
map('n', '<leader>be', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open file explorer at current buffer' })

--- mini.git ---
map('n', '<leader>ga', '<Cmd>Git add -- %<CR>', { desc = 'Git add current file' })
map('n', '<leader>gA', '<Cmd>Git add .<CR>', { desc = 'Git add all files' })
map('n', '<leader>gc', '<Cmd>Git commit<CR>', { desc = 'Git commit' })
map('n', '<leader>gC', function() vim.api.nvim_feedkeys(':Git checkout ', 'n', false) end, { desc = 'Git checkout' })
map('n', '<leader>gd', '<Cmd>Git diff HEAD -- %<CR>', { desc = 'Git diff current file' })
map('n', '<leader>gD', '<Cmd>Git diff HEAD<CR>', { desc = 'Git diff' })
map('n', '<leader>gf', '<Cmd>Git fetch<CR>', { desc = 'Git fetch' })
map('n', '<leader>gl', '<Cmd>Git log -10<CR>', { desc = 'Git log' })
map('n', '<leader>gp', '<Cmd>Git pull<CR>', { desc = 'Git pull' })
map('n', '<leader>gP', '<Cmd>Git push<CR>', { desc = 'Git push' })
map('n', '<leader>gr', '<Cmd>Git restore --staged %<CR>', { desc = 'Git unstage current file' })
map('n', '<leader>gR', '<Cmd>Git restore -- %<CR>', { desc = 'Git restore current file' })
map('n', '<leader>gs', '<Cmd>Git status<CR>', { desc = 'Git status' })
map('n', '<leader>gS', '<Cmd>Git stash --staged<CR>', { desc = 'Git stash staged' })
map('n', '<leader>gu', '<Cmd>Git reset --soft HEAD~1<CR>', { desc = 'Git undo last commit' })

--- mini.pick ---
local MiniPick = require('mini.pick')
map('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
map('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
map('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'Resume picker' })
map('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
map('n', '<leader>bb', function() MiniPick.builtin.buffers() end, { desc = 'Pick buffer' })
map('n', '<leader>sg', function() MiniPick.builtin.grep_live() end, { desc = 'Search live grep' })

--- mini.session ---
local MiniSessions = require('mini.sessions')
map('n', '<leader>qs', function() MiniSessions.select('read') end, { desc = 'Load session' })
map('n', '<leader>qc', function()
    vim.ui.input({
        prompt = 'Session name: ',
    }, function(name)
        if name and name ~= '' then
            MiniSessions.write(name)
        end
    end)
end, { desc = 'Create session' })
map('n', '<leader>qw', function() MiniSessions.select('write') end, { desc = 'Write session' })
map('n', '<leader>qd', function() MiniSessions.select('delete') end, { desc = 'Delete session' })

--- LSP ---
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }

        local function lsp_map(mode, lhs, rhs, desc)
            map(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
        end

        lsp_map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        lsp_map('n', 'gr', vim.lsp.buf.references, 'Go to references')
        lsp_map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        lsp_map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')

        lsp_map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        lsp_map('n', '<leader>cf', vim.lsp.buf.format, 'Format File')
        lsp_map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
        lsp_map('n', '<leader>cs', vim.lsp.buf.document_symbol, 'Symbol list')

        lsp_map('n', '<leader>cd', vim.diagnostic.open_float, 'Show diagnostics window')
        lsp_map('n', '[d', vim.diagnostic.goto_prev, 'Go to prev diagnostic')
        lsp_map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
    end,
})
