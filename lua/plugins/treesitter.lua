return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        indent = {
            enable = true,
            disable = { "cpp" },
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "cpp" },
        },
    },
}
