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

-- LSP options
vim.diagnostic.config({ virtual_text = true }) -- Show diagnostic messages as virtual text after the code

-- Color scheme settings
vim.cmd('colorscheme kanagawa')
-- Remove status line background
vim.cmd(':hi statusline guibg=NONE')
