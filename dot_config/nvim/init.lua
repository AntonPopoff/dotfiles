-- Neovim config start!

-- Map Leader key to Space
vim.g.mapleader = ' '

-- Vim tab options
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Misc Vim options
vim.o.scrolloff = 5            -- Add top and bottom padding of 5 lines when scrolling text
vim.o.number = true            -- Show line numbers
vim.o.relativenumber = true    -- Make line numbers relative
vim.o.splitright = true        -- When splitting vertically put the new window to the right
vim.o.splitbelow = true        -- When splitting horizontally put the new window to the bottom
vim.o.ignorecase = true        -- Make Vim search case insensitive
vim.o.smartcase = true         -- Make Vim search case sensitive if the pattern contains any uppercase letter
vim.o.undofile = true          -- Persist undo file between Vim sessions
vim.o.signcolumn = 'yes'       -- Always reserve and show one column for signs (LSP warnings/errors)
vim.o.winborder = 'rounded'    -- Enable rounded borders around floating windows
vim.o.cursorline = true        -- Enable current line highlighting
vim.o.cursorlineopt = 'number' -- Highlight only the current line number

-- Make invisible characters visible
-- tab:»    a tab character shows as » followed by spaces (catches tabs in space-indented files)
-- trail:·  trailing spaces at the end of a line show as dots
-- nbsp:␣   non-breaking spaces (break shell commands) become visible
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'

-- Hide invisible characters while typing to make insert mode less noisy
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function() vim.wo.list = false end,
})
-- Show invisible characters in other modes
vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function() vim.wo.list = true end,
})

-- Setup vim.pack hook to run commands upon plugins installation or update
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        -- Build telescope-fzf-native package after installation or update
        if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
            vim.system({ 'make' }, { cwd = ev.data.path }):wait()
        end

        -- Update nvim-treesitter parsers every time the plugin is installed or updated
        if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd(':TSUpdate')
        end
    end
})

-- Declare and install plugins with vim.pack
vim.pack.add({
    -- Kanagawa color scheme
    'https://github.com/rebelot/kanagawa.nvim',

    -- Treesitter
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'main'
    },

    -- Telescope plugin and its dependencies
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',

    -- Oil file manager plugin
    'https://github.com/stevearc/oil.nvim',
    -- Vim-fugitive git plugin
    'https://github.com/tpope/vim-fugitive',
    -- Undo tree plugin
    'https://github.com/mbbill/undotree',

    -- LSP Config and Mason
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',

    -- Modern autocompletion menu
    {
        src = 'https://github.com/Saghen/blink.cmp',
        version = vim.version.range('1.*')
    },
})

-- Tweak Kanagawa color scheme
require('kanagawa').setup({
    compile = true,
    transparent = true,
    -- Remove line numbers column background
    colors = { theme = { all = { ui = { bg_gutter = 'none', } } } },
    overrides = function(colors)
        local theme = colors.theme
        return {
            -- The ~ lines after the end of the file, and other "non-text" filler
            EndOfBuffer = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
            NonText = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
            -- Remove Telescope's own backgrounds so its windows work with the transparent background
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopeResultsBorder = { fg = theme.ui.nontext, bg = 'none' },
            TelescopePreviewBorder = { fg = theme.ui.nontext, bg = 'none' },
            TelescopePromptBorder = { fg = theme.ui.nontext, bg = 'none' },
            TelescopePromptNormal = { bg = 'none' },
            TelescopeResultsNormal = { bg = 'none' },
            TelescopePreviewNormal = { bg = 'none' },
        }
    end
})
-- Apply Kanagawa Dragon variant
vim.cmd('colorscheme kanagawa-dragon')

-- Install commonly used tree-sitter parsers
require('nvim-treesitter').install({
    -- Systems
    'asm', 'c', 'cpp', 'rust', 'go',
    -- JVM
    'kotlin', 'java', 'groovy',
    -- Shell and tooling
    'bash', 'zsh', 'awk', 'make', 'dockerfile', 'passwd', 'editorconfig',
    -- Web and data
    'html', 'css', 'javascript', 'yaml', 'toml', 'xml',
    -- Docs and scripting
    'markdown', 'markdown_inline', 'python',
})

-- Turn treesitter on for every buffer whose language has a parser
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)

        if not lang or not vim.treesitter.language.add(lang) then
            return
        end

        vim.treesitter.start(ev.buf, lang)
    end,
})

-- Telescope setup
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
-- Load native package for fzf finder
pcall(telescope.load_extension, 'fzf')

-- Telescope mappings
local telescope_funcs = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', telescope_funcs.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<Leader>fg', telescope_funcs.live_grep, { desc = 'Grep project' })
vim.keymap.set('n', '<Leader>fm', telescope_funcs.marks, { desc = 'Marks' })
vim.keymap.set('n', '<Leader>fh', telescope_funcs.help_tags, { desc = 'Help tags' })

-- Oil setup
require('oil').setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    view_options = {
        show_hidden = true
    },
})

-- Setup LSP and Mason
require('mason').setup()
vim.lsp.enable('lua_ls')                       -- Enable lua-language-server
vim.lsp.enable('clangd')                       -- Enable clangd (C/C++ language server)
vim.diagnostic.config({ virtual_text = true }) -- Show diagnostic messages as virtual text after the code

-- Load and setup autocompletion plugin
require('blink.cmp').setup({
    sources = {
        -- Remove 'buffer' because we don't want plain text completions
        default = { 'lsp', 'path', 'snippets' },
    },
})

-- Register LSP attach autocommand to setup mappings, etc.
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if not client then
            return
        end

        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'Rename symbol' })
        vim.keymap.set('n', '<Leader>fc', vim.lsp.buf.format, { buffer = ev.buf, desc = 'Format buffer' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to definition' })
        vim.keymap.set({ 'n', 'x' }, '<M-CR>', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code action' })
        vim.keymap.set('n', '<Leader>fr', telescope_funcs.lsp_references, { buffer = ev.buf, desc = 'Find references' })
    end,
})

-- Oil mappings
vim.keymap.set('n', '<Leader>e', vim.cmd.Oil, { desc = 'File explorer (Oil)' })

-- UndoTree mappings
vim.keymap.set('n', '<Leader>ut', vim.cmd.UndotreeToggle, { desc = 'Undo tree' })

-- Vim bindings start
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>') -- Disable 'Space' key so it only acts as Leader
vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', '<Esc>', { desc = 'Escape' })

-- Disable arrow keys
vim.keymap.set({ 'n', 'i', 'x' }, '<Down>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'x' }, '<Up>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'x' }, '<Left>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'x' }, '<Right>', '<Nop>')

-- Clipboard and yank register mappings
vim.keymap.set('n', '<Leader>yy', '"+yy', { desc = 'Copy line to clipboard' })
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p', { desc = 'Paste from clipboard after cursor' })
vim.keymap.set('n', '<Leader>P', '"+P', { desc = 'Paste from clipboard before cursor' })

-- Split panes and tabs mappings
vim.keymap.set('n', '<Leader>wv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<Leader>wh', '<cmd>split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<Leader>tn', '<cmd>tabe<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<Leader>wr', '<C-w>r', { desc = 'Rotate splits' })
vim.keymap.set('n', '<Leader>q', '<cmd>q<CR>', { desc = 'Close current window' })

-- Split panes navigation mappings
vim.keymap.set('n', '<Leader>j', '<C-w>j', { desc = 'Move to split below' })
vim.keymap.set('n', '<Leader>k', '<C-w>k', { desc = 'Move to split above' })
vim.keymap.set('n', '<Leader>h', '<C-w>h', { desc = 'Move to split left' })
vim.keymap.set('n', '<Leader>l', '<C-w>l', { desc = 'Move to split right' })

-- Split panes resizing
vim.keymap.set('n', '<Leader>we', '<C-w>=', { desc = 'Equalize split sizes' })
vim.keymap.set('n', '<M-t>', '<C-w>5+', { desc = 'Increase split height' })
vim.keymap.set('n', '<M-s>', '<C-w>5-', { desc = 'Decrease split height' })
vim.keymap.set('n', '<M-w>', '<C-w>5>', { desc = 'Increase split width' })
vim.keymap.set('n', '<M-n>', '<C-w>5<', { desc = 'Decrease split width' })

-- Place the cursor at the center of the screen after scroll actions
-- Execute the commands via vim.cmd to prevent screen flickering

-- Helper function to replace terminal sequences like <C-x> with the real internal key codes
-- Return a function which executes the parsed command
local function scroll_and_center(key_seq)
    local prepared = vim.api.nvim_replace_termcodes(key_seq, true, false, true)
    return function() vim.cmd('normal!' .. prepared) end
end

vim.keymap.set('n', '<C-d>', scroll_and_center('<C-d>zz'), { desc = 'Scroll half page down (centered)' })
vim.keymap.set('n', '<C-u>', scroll_and_center('<C-u>zz'), { desc = 'Scroll half page up (centered)' })
vim.keymap.set('n', '<C-f>', scroll_and_center('<C-f>zz'), { desc = 'Scroll page down (centered)' })
vim.keymap.set('n', '<C-b>', scroll_and_center('<C-b>zz'), { desc = 'Scroll page up (centered)' })

-- Place search result at the center of the screen and open folds
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
