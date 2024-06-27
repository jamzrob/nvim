-- line numbers
vim.o.nu = true
vim.o.relativenumber = true

-- tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- indents
vim.o.smartindent = true

vim.o.wrap = true

-- no swaps
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("XDG_CONFIG_HOME") .. "/undo"
vim.o.undofile = true

-- searching
vim.o.hlsearch = true
vim.o.incsearch = true

-- colors
vim.o.termguicolors = true
vim.o.colorcolumn = ""

-- scrolling
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update time
vim.o.updatetime = 50

-- text width
vim.o.textwidth = 80
vim.o.wrap = true
vim.o.linebreak = true

-- auto writing
vim.o.autowrite = true

-- move jarring splits outta here
vim.o.spr = true
vim.o.splitright = true


-- clipboard
vim.o.clipboard = "unnamedplus"

-- no vi compatbile
vim.o.compatible = false


-- turn off comments
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- autowrap and make comments
--


-- fzf
vim.opt.rtp:append("/usr/local/opt/fzf")
