-- Minimal Key Mappings
local keymap = vim.keymap.set

-- File operations
keymap('n', 'fw', ':w!<CR>', { desc = 'Save file' })
keymap('n', 'fq', ':q!<CR>', { desc = 'Quit' })
keymap('n', 'fv', ':vsplit<CR>', { desc = 'Vertical split' })
keymap('n', 'fs', ':split<CR>', { desc = 'Horizontal split' })

-- Terminal mode escape
keymap('t', 'fq', "<C-\\><C-n>", { desc = 'Exit terminal mode' })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = 'Move to left window' })
keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = 'Move to bottom window' })
keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = 'Move to top window' })
keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = 'Move to right window' })

-- Tab navigation
keymap('n', 'fn', ':tabnew<CR>', { desc = 'New tab' })
keymap('n', 'fj', ':tabprev<CR>', { desc = 'Previous tab' })
keymap('n', 'fk', ':tabnext<CR>', { desc = 'Next tab' })
keymap('n', 'tq', ':tabclose<CR>', { desc = 'Close tab' })

-- Search
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = 'Clear search highlight' })
keymap("n", "<leader>H", ":set hlsearch<CR>", { desc = 'Enable search highlight' })

-- Reload current file
keymap('n', '<leader>e', ':e!<CR>', { desc = 'Reload file' })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open file explorer" })

-- FZF Fuzzy Finder
keymap('n', '<leader>g', ':FzfLua git_files<CR>', { desc = 'Git files (fzf)' })
keymap('n', '<leader>f', ':FzfLua files<CR>', { desc = 'Find files (fzf)' })
keymap('n', '<leader>b', ':FzfLua buffers<CR>', { desc = 'Buffers (fzf)' })
keymap('n', '<leader>s', ':FzfLua live_grep<CR>', { desc = 'Live grep (fzf)' })
keymap('n', '<leader>w', ':FzfLua grep_cword<CR>', { desc = 'Grep word under cursor (fzf)' })
keymap('n', '<leader>c', function() require('fzf-lua').git_status() end, { desc = 'Git status (fzf)' })

-- LSP Diagnostics
keymap('n', '<leader>D', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Show diagnostic' })
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous diagnostic' })
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Next diagnostic' })
keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = 'Diagnostic location list' })

-- Common
keymap("n", 'H', '^')
keymap("n", 'L', '$')
