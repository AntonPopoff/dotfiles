-- Vim tab options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- Misc Vim options
vim.opt.scrolloff = 5                          -- Add top and bottom padding of 5 lines when scrolling text
vim.opt.number = true                          -- Show line numbers
vim.opt.relativenumber = true                  -- Make line numbers relative
vim.opt.splitright = true                      -- Show vertical split on the right side
vim.opt.ignorecase = true                      -- Make Vim search case insensitive 
vim.opt.smartcase = true                       -- Make Vim search case sensitive only if the first letter is capital
vim.opt.undofile = true                        -- Persist undo file between Vim sessions
vim.opt.signcolumn = 'yes:1'                   -- Always reserve and show one column for signs (LSP warnings/errors)

-- LSP options
vim.diagnostic.config({ virtual_text = true }) -- Show diagnostic messages as virtual text after the code
