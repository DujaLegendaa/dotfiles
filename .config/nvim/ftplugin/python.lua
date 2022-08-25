local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<F8>", "<cmd>lua _IPYTHON_TOGGLE()<cr>", opts)
keymap("n", "<F9>", ":w<cr><cmd>lua _PYTHON_RUN()<cr>", opts)
keymap("i", "<F9>", "<esc>:w<cr><cmd>lua _PYTHON_RUN()<cr>", opts)
