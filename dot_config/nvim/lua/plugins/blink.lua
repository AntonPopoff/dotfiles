return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        opts = {
            keymap = {
                preset = 'enter',
                ['<Down>'] = { function(cmp) cmp.select_next({ auto_insert = false }) end },
                ['<Up>'] = { function(cmp) cmp.select_prev({ auto_insert = false }) end },
                ['<C-n>'] = { function(cmp) cmp.select_next({ auto_insert = false }) end },
                ['<C-p>'] = { function(cmp) cmp.select_prev({ auto_insert = false }) end },
            },
            appearance = { nerd_font_variant = 'mono' },
            completion = { documentation = { auto_show = false } },
            sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
            fuzzy = { implementation = 'prefer_rust_with_warning' }
        },
        opts_extend = { 'sources.default' }
    }
}
