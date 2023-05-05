vim.g.mapleader = " "

-- Copy to clipboard
vim.keymap.set("v", "<C-c>", [["+y]])

-- Movement
vim.keymap.set("n", "<leader>h", "<Cmd>wincmd h<CR>", { desc = "Move cursor to left window" })
vim.keymap.set("n", "<leader>j", "<Cmd>wincmd j<CR>", { desc = "Move cursor to bottomw window" })
vim.keymap.set("n", "<leader>k", "<Cmd>wincmd k<CR>", { desc = "Move cursor to top window" })
vim.keymap.set("n", "<leader>l", "<Cmd>wincmd l<CR>", { desc = "Move cursor to right window" })
vim.keymap.set("n", "<leader>+", "<Cmd>vertical resize +5<CR>", { desc = "Resize window +5" })
vim.keymap.set("n", "<leader>-", "<Cmd>vertical resize -5<CR>", { desc = "Resize window -5" })
vim.keymap.set("n", "<C-S>", "<Cmd>write<CR>", { desc = "Save buffer" })

-- Tabs
vim.keymap.set("n", "<leader>q", "<Cmd>bprevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>e", "<Cmd>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>w", "<Cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Diagnostics
-- utils.key_mapper('n', '<leader>dn', ':lua vim.diagnostic.goto_next({float={border="rounded"}})<CR>')
-- utils.key_mapper('n', '<leader>dp', ':lua vim.diagnostic.goto_prev({float={border="rounded"}})<CR>')
-- utils.key_mapper('n', '<leader>ds', ':lua vim.diagnostic.open_float({ focusable = false, border="rounded" })<CR>')
