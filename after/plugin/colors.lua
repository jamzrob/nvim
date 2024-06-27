vim.g.mapleader = " "
local keyset = vim.keymap.set

require('rose-pine').setup({
    disable_background = true,
})

require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})

require('kanagawa').setup({})
require('catppuccin').setup({})
require('material').setup({})
require('tokyonight').setup({})



function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", ctermbg = "none" })
    vim.api.nvim_set_hl(0, "Float", { bg = "none", ctermbg = "none" })
    vim.api.nvim_set_hl(0, "ColorColumn", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = "none", ctermbg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#595959", bg = "#3b2e2b" })

    vim.cmd([[
        highlight jukit_cellmarker_colors guifg=#404040 guibg=#404040 ctermbg=22 ctermfg=22
        highlight jukit_textcell_bg_colors guibg=#404040 ctermbg=0
    ]])

    vim.opt.signcolumn = "no"
end

vim.api.nvim_create_user_command(
    'Gruv',
    function()
        ColorMyPencils("gruvbox")
    end,
    { desc = "Change to gruvbox" }
)

vim.api.nvim_create_user_command(
    'Rose',
    function()
        ColorMyPencils("rose-pine")
    end,
    { desc = "Change to gruvbox" }
)

vim.api.nvim_create_user_command(
    'Kanagawa',
    function()
        ColorMyPencils("kanagawa")
    end,
    { desc = "Change to kanagawa" }
)

vim.api.nvim_create_user_command(
    'DesertNight',
    function()
        ColorMyPencils("desert-night")
    end,
    { desc = "Change to desert-night" }
)

vim.api.nvim_create_user_command(
    'Cat',
    function()
        ColorMyPencils("catppuccino")
    end,
    { desc = "Change to catppuccino" }
)


vim.api.nvim_create_user_command(
    'Desert',
    function()
        ColorMyPencils("desert")
    end,
    { desc = "Change to desert" }
)

vim.api.nvim_create_user_command(
    'Material',
    function()
        ColorMyPencils("material")
    end,
    { desc = "Change to material" }
)

vim.api.nvim_create_user_command(
    'TokyoNight',
    function()
        ColorMyPencils("tokyonight")
    end,
    { desc = "Change to tokyonight" }
)

vim.api.nvim_create_user_command(
    'Sonokai',
    function()
        ColorMyPencils("sonokai")
    end,
    { desc = "Change to sonokai" }
)

vim.api.nvim_create_user_command(
    'Everforest',
    function()
        ColorMyPencils("everforest")
    end,
    { desc = "Change to everforest" }
)

vim.api.nvim_create_user_command(
    'GruvboxMaterial',
    function()
        ColorMyPencils("gruvbox-material")
    end,
    { desc = "Change to gruvbox-material" }
)

vim.api.nvim_create_user_command(
    'Edge',
    function()
        ColorMyPencils("edge")
    end,
    { desc = "Change to edge" }
)

vim.api.nvim_create_user_command(
    'RandomColor',
    function()
        local colors = {
            "rose-pine",
            "gruvbox",
            "kanagawa",
            "desert-night",
            "catppuccin",
            "desert",
            "material",
            "tokyonight",
            "sonokai",
            "everforest",
            "gruvbox-material",
            "edge",
        }
        ColorMyPencils(colors[math.random(#colors)])
    end,
    { desc = "Change to random color" }
)

vim.api.nvim_create_user_command(
    'ColorMyPencils',
    function()
        ColorMyPencils()
    end,
    { desc = "Change to default color" }
)

-- run Random color command
vim.cmd("RandomColor")

vim.cmd([[
    command! -bang -nargs=? -complete=dir Files  call fzf#vim#colors({'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)
]])
