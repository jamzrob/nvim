vim.keymap.set("n", "<leader>gw", require('telescope').extensions.git_worktree.git_worktree) vim.keymap.set("n", "<leader>gc", require('telescope').extensions.git_worktree.git_worktree)

local wk = require("which-key")
wk.register({
    g = {
        name = "Woktree",
        -- <Enter> - switches to that worktree
        -- <c-d> - deletes that worktree
        -- <c-f> - toggles forcing of the next deletion
        f = {"<cmd>lua require('telescope').extensions.git_worktree.git_worktree()<CR>", "Search worktrees"},
        c = {"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", "Create worktree"},
    },
    prefix = "<leader>"
})
