local vim = vim
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

local MiniFiles = require('mini.files')
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
