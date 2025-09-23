return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    opts = {
        compile = true,
        transparent = true,
        colors = {
            theme = {
                all = {
                    ui = {
                        -- Remove line numbers column background
                        bg_p2 = 'none',
                        -- Remove cursor line background
                        bg_gutter = 'none',
                    }
                }
            }
        },
        overrides = function(colors)
            local theme = colors.theme

            -- Tweak some Telescope window colors
            return {
                EndOfBuffer = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
                NonText = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
                -- Remove background color from Telescope borders to make it work with transparent background
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
}
