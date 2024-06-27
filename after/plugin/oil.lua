require("oil").setup({
    view_options = {
        show_hidden = true
    }
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>pv", ":vsplit<CR><C-w>h")
vim.keymap.set("n", "<leader>sv", ":split<CR>")
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
