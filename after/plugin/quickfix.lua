-- use <C-N> and <C-P> for next/prev.
vim.keymap.set("n", "<C-p>", ":cprev<CR>")
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
-- toggle the quickfix open/closed without jumping to it
vim.keymap.set("n", "<leader>q", ":call ToggleQuickfixList()<CR>")

