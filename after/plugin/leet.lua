vim.api.nvim_create_user_command(
    'L',
    function()
        vim.cmd("Leet")
    end,
    { desc = "Open leet" }
)

vim.api.nvim_create_user_command(
    'LT',
    function()
        vim.cmd("Leet test")
    end,
    { desc = "Test leetcode" }
)

vim.api.nvim_create_user_command(
    'LS',
    function()
        vim.cmd("Leet submit")
    end,
    { desc = "Submit leetcode" }
)

vim.api.nvim_create_user_command(
    'LO',
    function()
        vim.cmd("Leet open")
    end,
    { desc = "Open leetcode" }
)
