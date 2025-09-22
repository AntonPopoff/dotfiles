return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        opts = {
            keymap = { preset = 'enter' },
            completion = {
                list = { selection = { preselect = true, auto_insert = false } },
                ghost_text = { enabled = false },
                documentation = { auto_show = false },
            },
            sources = { default = { 'lsp', 'path', 'snippets' }, },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            appearance = { nerd_font_variant = 'mono' },
        },
        opts_extend = { 'sources.default' }
    }
}
