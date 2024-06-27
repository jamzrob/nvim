vim.keymap.set("i", "<C-]>", "copilot#Next()", { remap = true, expr = true, silent = true })
vim.keymap.set("i", "<C-[>", "copilot#Previous()", { remap = true, expr = true, silent = true })
vim.keymap.set("i", "<C-S>", "copilot#Suggest()", { remap = true, expr = true, silent = true })
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
