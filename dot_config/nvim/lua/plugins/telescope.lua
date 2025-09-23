return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    config = function()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                layout_strategy = 'horizontal',
                path_display = { 'truncate' },
                layout_config = {
                    horizontal = {
                        width = 0.85,
                        preview_width = 0.55
                    },
                },
            },
        })
        telescope.load_extension('fzf')
    end,
    keys = {
        { '<Leader>ff', '<cmd>Telescope find_files<cr>',     mode = 'n' },
        { '<Leader>fg', '<cmd>Telescope live_grep<cr>',      mode = 'n' },
        { '<Leader>fm', '<cmd>Telescope marks<cr>',          mode = 'n' },
        { '<Leader>fh', '<cmd>Telescope help_tags<cr>',      mode = 'n' },
        { '<Leader>fr', '<cmd>Telescope lsp_references<cr>', mode = 'n' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            lazy = true,
        }
    },
}
