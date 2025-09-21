return {
    'stevearc/oil.nvim',
    lazy = true,
    opts = {
        view_options = { show_hidden = true, },
    },
    keys = {
        { '<Leader>e', vim.cmd.Oil, mode = 'n' },
    },
}
