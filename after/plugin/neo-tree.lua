require("neo-tree").setup({
    window = {
        position = "float",
        -- disable fuzzy finder
        mappings = {
            ["/"] = "noop"
        }
    },
    filesystem = {
        filtered_items = {
            visible = true,
        },
        hijack_netrw_behavior = "disabled",
    }
})

vim.keymap.set("n", "<leader>E", ":Neotree toggle current reveal_force_cwd<CR>")
