return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        opts = {
            theme = 'dragon',
            background = 'none',
            transparent = true,
            compile = true,
            overrides = function(colors)
                local theme = colors.theme
                return {
                    -- Tweak some Telescope window colors
                    EndOfBuffer = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
                    NonText = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopeResultsBorder = { fg = theme.ui.nontext, bg = 'none' },
                    TelescopePreviewBorder = { fg = theme.ui.nontext, bg = 'none' },
                    TelescopePromptBorder = { fg = theme.ui.nontext, bg = 'none' },
                    TelescopePromptNormal = { bg = 'none' },
                    TelescopeResultsNormal = { bg = 'none' },
                    TelescopePreviewNormal = { bg = 'none' },
                }
            end
        },
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = 'none', bg_p2 = 'none'
                    }
                }
            }
        },
    },
}
