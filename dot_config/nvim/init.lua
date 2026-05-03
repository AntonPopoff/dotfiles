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
vim.o.scrolloff = 5         -- Add top and bottom padding of 5 lines when scrolling text
vim.o.number = true         -- Show line numbers
vim.o.relativenumber = true -- Make line numbers relative
vim.o.splitright = true     -- Show vertical split on the right side
vim.o.ignorecase = true     -- Make Vim search case insensitive
vim.o.smartcase = true      -- Make Vim search case sensitive only if the first letter is capital
vim.o.undofile = true       -- Persist undo file between Vim sessions
vim.o.signcolumn = 'yes'    -- Always reserve and show one column for signs (LSP warnings/errors)
vim.o.winborder = 'rounded' -- Enable rounded borders around floating windows
vim.o.cursorline = true     -- Highlight current line number

-- Setup vim.pack hook to run commands upon plugins installation or update
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        -- Build telescope-fzf native package after installation or update
        if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
            vim.system({ 'make' }, { cwd = ev.data.path })
        end
    end
})

-- Declare and install plugins with vim.pack
vim.pack.add({
    -- Kanagawa color scheme
    'https://github.com/rebelot/kanagawa.nvim',

    -- Telescope plugin and its dependencies
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',

    -- Oil file manager plugin
    'https://github.com/stevearc/oil.nvim',
    -- Vim-fugutive git plugin
    'https://github.com/tpope/vim-fugitive',
    -- Undo tree plugin
    'https://github.com/mbbill/undotree',

    -- LSP Config and Mason
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
})

-- Tweak Kanagawa color scheme
require('kanagawa').setup({
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
})
-- Apply Kanagawa Dragon variant
vim.cmd('colorscheme kanagawa-dragon')

-- Telescope setup and mappings
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
telescope.load_extension('fzf')

-- Telescope mappings
local telescope_funcs = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', telescope_funcs.find_files)
vim.keymap.set('n', '<Leader>fg', telescope_funcs.live_grep)
vim.keymap.set('n', '<Leader>fm', telescope_funcs.marks)
vim.keymap.set('n', '<Leader>fh', telescope_funcs.help_tags)

-- Oil setup and mappings
require('oil').setup()
vim.keymap.set('n', '<Leader>e', vim.cmd.Oil)

-- Undo tree mappings
vim.keymap.set('n', '<Leader>ut', vim.cmd.UndotreeToggle)

-- Setup LSP and Mason
require('mason').setup()
vim.lsp.enable('lua_ls')                       -- Enable lua-language-server
vim.diagnostic.config({ virtual_text = true }) -- Show diagnostic messages as virtual text after the code

-- Setup LSP mappings only when we have one attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)       -- Rename
        vim.keymap.set('n', '<Leader>fc', vim.lsp.buf.format, opts)       -- Buffer format
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)           -- Go to definition
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                 -- Hover documentation
        vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action)   -- Code actions
        vim.keymap.set('n', '<Leader>fr', telescope_funcs.lsp_references) -- LSP code references
    end,
})

-- Vim bindings start
vim.keymap.set({ 'n', 'v' }, '<Space>', '<nop>')    -- Disable 'Space' key
vim.keymap.set({ 'n', 'i', 'v' }, '<C-c>', '<Esc>') -- Map CTRL+c to Escape

-- Disable arrow keys
vim.keymap.set({ 'n', 'i', 'v' }, '<Down>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<Up>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<Left>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<Right>', '<Nop>')

-- Clipboard and yank buffer mappings
vim.keymap.set('n', '<Leader>yy', '"+yy')        -- Copy to OS clipboard an entire line in normal mode
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y') -- Copy to OS clipboard in visual and normal mode
vim.keymap.set({ 'v', 'n' }, '<Leader>p', '"+p') -- Paste from OS clipboard after the cursor
vim.keymap.set('n', '<Leader>P', '"+P')          -- Paste without putting content into a register
vim.keymap.set('v', '<Leader>P', '"_dP')         -- Paste without putting content into a register

-- Disable search highlighting
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>')

-- Split panes and tabs mappings
vim.keymap.set('n', '<Leader>wv', ':vsplit<CR>') -- Create a new vertical split
vim.keymap.set('n', '<Leader>wh', ':split<CR>')  -- Create a new horizontal split
vim.keymap.set('n', '<Leader>tn', ':tabe<CR>')   -- Create a new tab
vim.keymap.set('n', '<Leader>q', ':q<CR>')       -- Close current active buffer

-- Split panes navigation mappings <Leader> shortcuts
vim.keymap.set('n', '<Leader>r', '<C-w>r') -- Rotate split panes
vim.keymap.set('n', '<Leader>j', '<C-w>j')
vim.keymap.set('n', '<Leader>k', '<C-w>k')
vim.keymap.set('n', '<Leader>h', '<C-w>h')
vim.keymap.set('n', '<Leader>l', '<C-w>l')

-- Split panes resizing
vim.keymap.set('n', '<Leader>we', '<C-w>=') -- Equalize splits' sizes
vim.keymap.set('n', '<M-t>', '<C-w>5+')
vim.keymap.set('n', '<M-s>', '<C-w>5-')
vim.keymap.set('n', '<M-w>', '<C-w>5>')
vim.keymap.set('n', '<M-n>', '<C-w>5<')

-- Place cursor at the center of the screen while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- Place search result at the center of the screen
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
