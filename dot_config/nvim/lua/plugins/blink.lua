return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        opts = {
            -- Press 'enter' to accept a completion item
            keymap = { preset = 'enter' },
            completion = {
                -- Preselect the first completion item in the list but without inserting it into buffer
                list = { selection = { preselect = true, auto_insert = false } },
                ghost_text = { enabled = false },
                documentation = { auto_show = false },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    -- Add LazyDev provider to make blink's completion work with Neovim configs
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
            -- Use Rust fuzzy search by default
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            appearance = { nerd_font_variant = 'mono' },
        },
        opts_extend = { 'sources.default' }
    }
}
