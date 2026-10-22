local vim = vim
local create_autocmd = vim.api.nvim_create_autocmd
local create_user_cmd = vim.api.nvim_create_user_command

create_autocmd('QuitPre', {
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buftype == 'terminal' then
                pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
        end
    end,
})

create_user_cmd('CMakeBuildType', function(opts)
    local build_type = opts.args
    if build_type ~= 'Debug' and build_type ~= 'Release' then
        vim.notify('Use :CMakeBuildType Debug or Release', vim.log.levels.ERROR)
        return
    end

    vim.fn.jobstart({
            'cmake',
            '-S', '.',
            '-B', 'build',
            '-DCMAKE_BUILD_TYPE=' .. build_type,
        },
        {
            stdout_buffered = true,
            on_exit = function(_, code)
                if code == 0 then
                    vim.notify('CMake build type set to ' .. build_type)
                else
                    vim.notify('CMake configuration failed', vim.log.levels.ERROR)
                end
            end,
        })
end, {
    nargs = 1,
    complete = function()
        return { 'Debug', 'Release' }
    end,
})
