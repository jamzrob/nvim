vim.g.mapleader = " "
vim.g.maplocalleader = ","

--der moving lines vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor with J
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- delete to void
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vertical mode needs this
vim.keymap.set("i", "<C-c>", "<Esc>")

-- not fun to press
vim.keymap.set("n", "Q", "<nop>")

-- switch projects
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- replace word you are on
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- give executable permissions
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Tab navigation
vim.keymap.set("n", "<leader>t", "zz:tabnew<CR>")

-- Split windows
vim.keymap.set("n", "<leader>pv", ":Vex!<CR>")
vim.keymap.set("n", "<leader>sv", ":sp!<CR>")
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- reload config
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- toggle page back
vim.keymap.set("n", "<C-b>", "<C-^>")

-- Open file tree
vim.keymap.set("n", "<c-x>", ":Ex<CR>")


-- Yank file path
vim.keymap.set("n", "cp", ":let @\" = expand(\"%\")<cr>");


-- open config file
function OpenFileInVerticalSplit(path)
    vim.cmd('vsp ' .. path)
end

-- etsy tests
vim.api.nvim_set_keymap('n', '<leader>T', [[:tabe `run_test -n %`<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rt', [[:!run_test %<CR>]], { noremap = true, silent = true })


-- wrap wonder under cursor in console.log
function _G.log_word()
    local word = vim.fn.expand('<cword>')
    if word ~= '' then
        vim.fn.setreg('1', 'console.log("' .. word .. ': ", ' .. word .. ');')
        vim.cmd('normal! viw"1P')
    end
end

function _G.packer_sync()
    vim.cmd('normal! :PackerSync<CR>')
end

vim.api.nvim_command([[command! -nargs=? PS lua packer_sync()]])

vim.api.nvim_command([[command! -nargs=? LogWord lua log_word(<f-args>)]])
vim.api.nvim_set_keymap('n', '<leader>cl', ":LogWord<CR>", { noremap = true, silent = true })



--  ETSY
vim.api.nvim_set_keymap('n', '<leader>T', [[:tabe `run_test -n %`<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rt', [[:!run_test %<CR>]], { noremap = true, silent = true })

function _G.git_link()
    local path = vim.fn.expand('%');
    local url = "https://github.etsycorp.com/Engineering/Etsyweb/tree/main/" .. path;
    vim.fn.setreg('"', url)
    print(url)
end

vim.api.nvim_command([[command! GitLink lua git_link()]])


local M = {}
