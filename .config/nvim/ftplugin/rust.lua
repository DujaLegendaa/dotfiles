local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<F9>", "<cmd>lua _CARGO_RUN()<cr>", opts)
