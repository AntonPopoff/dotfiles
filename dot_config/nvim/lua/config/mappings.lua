-- Vim bindings start

-- Disable some keys before doing everything else
vim.keymap.set({ 'n', 'v' }, '<Space>', '<nop>') -- Disable 'Space' key

-- Map CTRL+c to Escape
vim.keymap.set({ 'n', 'i', 'v' }, '<C-c>', '<Esc>')

-- Disable arrow keys
vim.keymap.set({ 'n', 'i', 'v' }, '<Down>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<Up>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<Left>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<Right>', '<Nop>')

-- OS clipboard mappings
vim.keymap.set({ 'v' }, '<Leader>y', '\"+y')      -- Copy to OS clipboard in visual mode
vim.keymap.set({ 'n' }, '<Leader>yy', '\"+yy')    -- Copy to OS clipboard an entire line in normal mode
vim.keymap.set({ 'v', 'n' }, '<Leader>p', '\"+p') -- Paste from OS clipboard after the cursor
vim.keymap.set({ 'v', 'n' }, '<Leader>P', '\"+P') -- Paste from OS clipboard before the cursor

-- Vim clipboard mapping
vim.keymap.set({ 'v' }, '<Leader>P', '"_dP') -- Delete without putting content into a register

-- Disable search highlighting
vim.keymap.set({ 'n' }, '<Leader>/', ':nohlsearch<CR>')

-- Split panes and tabs mappings
vim.keymap.set({ 'n' }, '<Leader>wv', ':vsplit<CR>') -- Create a new vertical split
vim.keymap.set({ 'n' }, '<Leader>wh', ':split<CR>')  -- Create a new horizontal split
vim.keymap.set({ 'n' }, '<Leader>tn', ':tabe<CR>')   -- Create a new tab
vim.keymap.set({ 'n' }, '<Leader>q', ':q<CR>')       -- Close current active buffer

-- Split panes navigation mappings <Leader> shortcuts
vim.keymap.set({ 'n' }, '<Leader>r', '<C-w>r') -- Rotate split panes
vim.keymap.set({ 'n' }, '<Leader>j', '<C-w>j')
vim.keymap.set({ 'n' }, '<Leader>k', '<C-w>k')
vim.keymap.set({ 'n' }, '<Leader>h', '<C-w>h')
vim.keymap.set({ 'n' }, '<Leader>l', '<C-w>l')

-- Split panes resizing
vim.keymap.set({ 'n' }, '<Leader>we', '<C-w>=') -- Equalize splits' sizes
vim.keymap.set({ 'n' }, '<M-t>', '<C-w>5+')
vim.keymap.set({ 'n' }, '<M-s>', '<C-w>5-')
vim.keymap.set({ 'n' }, '<M-w>', '<C-w>5>')
vim.keymap.set({ 'n' }, '<M-n>', '<C-w>5<')

-- Place cursor at the center of the screen while scrolling
vim.keymap.set({ 'n' }, '<C-d>', '<C-d>zz')
vim.keymap.set({ 'n' }, '<C-u>', '<C-u>zz')
vim.keymap.set({ 'n' }, '<C-f>', '<C-f>zz')
vim.keymap.set({ 'n' }, '<C-b>', '<C-b>zz')

-- Place search result at the center of the screen
vim.keymap.set({ 'n' }, 'n', 'nzz')
vim.keymap.set({ 'n' }, 'N', 'Nzz')

-- Lsp mappings
-- Format an entire buffer
vim.keymap.set({ 'n' }, '<Leader>fc', vim.lsp.buf.format)
-- Disable Omni completion mapping because we use blink.cmp
vim.keymap.set({ 'i' }, '<C-x><C-o>', '<Nop>')
