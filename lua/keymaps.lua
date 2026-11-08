local vim = vim
local map = vim.keymap.set

--- general ---
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>R', '<Cmd>restart<CR>', { desc = 'Restart Neovim' })
map('n', '<leader>qq', '<Cmd>quit<CR>', { desc = 'Quit Session' })

--- buffers ---
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

--- editing ---
map('v', '<leader>S', ':sort!<CR>', { desc = 'Reverse sort selection' })
map('v', '<leader>s', ':sort<CR>', { desc = 'Sort selection' })

--- terminal ---
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

--- mini.bufremove ---
local MiniBufRemove = require('mini.bufremove')
map('n', '<leader>bd', function() MiniBufRemove.delete() end, { desc = 'Close buffer' })

--- mini.diff ---
local MiniDiff = require('mini.diff')
map('n', '<leader>go', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })

--- mini.files ---
local MiniFiles = require('mini.files')
map('n', '<leader>E', function() MiniFiles.open(nil, false) end, { desc = 'Open file explorer' })
map('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open last file explorer' })
map('n', '<leader>be', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open file explorer at buffer' })

--- mini.git ---
map('n', '<leader>bg', '<Cmd>write | Git add -- %<CR>', { desc = 'Write buffer and stage' })
map('n', '<leader>gR', '<Cmd>Git restore -- %<CR>', { desc = 'Git restore current file' })
map('n', '<leader>ga', '<Cmd>Git add -- %<CR>', { desc = 'Git add current file' })
map('n', '<leader>gd', '<Cmd>Git diff HEAD -- %<CR>', { desc = 'Git diff current file' })
map('n', '<leader>gr', '<Cmd>Git restore --staged %<CR>', { desc = 'Git unstage current file' })

--- mini.pick ---
local MiniPick = require('mini.pick')
map('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
map('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
map('n', '<leader>fg', function() MiniPick.builtin.grep_live() end, { desc = 'Search live grep' })
map('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
map('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'Resume picker' })

--- mini.session ---
local MiniSessions = require('mini.sessions')
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

--- LSP ---
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
    end,
})
