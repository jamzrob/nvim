require("telescope").load_extension("refactoring")

vim.keymap.set(
    { "n", "x" },
    "<leader>RR",
    function() require('telescope').extensions.refactoring.refactors() end
)


vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end)
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end)
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end)
-- Extract block supports only normal mode

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.keymap.set(
    "n",
    "<leader>rp",
    function() require('refactoring').debug.printf({ below = false }) end
)

-- Print var

vim.keymap.set({ "x", "n" }, "<leader>rv", function() require('refactoring').debug.print_var() end)
-- Supports both visual and normal mode
