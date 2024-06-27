-- ensure the packer plugin manager is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    use {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('leetcode').setup({
                lang = "python3",
            })
        end,
        cmd = "Leet",
        opts = {
            -- configuration goes here
            lang = "python3"
        },
        plugins = {
            non_standalone = true,
        }
    }
    --- VimWiki
    use { 'vimwiki/vimwiki' }

    -- prettier
    use { 'prettier/vim-prettier' }

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    -- Undo Treesitter
    use('mbbill/undotree')

    -- Search
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("tpope/vim-fugitive")
    use {
        'junegunn/fzf.vim',
        requires = { 'junegunn/fzf', run = ':call fzf#install()' }
    }

    -- Harpoon
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Colors
    use({ 'rose-pine/neovim', as = 'rose-pine', })
    use({ "ellisonleao/gruvbox.nvim", as = "gruvbox" })
    use({ 'rebelot/kanagawa.nvim', as = 'kanagawa' })
    use({ 'kooparse/vim-color-desert-night', as = 'desert-night' })
    use({ 'catppuccin/nvim', as = 'catppuccin', })
    use({ 'fugalh/desert.vim', as = 'desert', })
    use({ 'marko-cerovac/material.nvim', as = 'material', })
    use({ 'folke/tokyonight.nvim', as = 'tokyonight', })
    use({ 'sainnhe/sonokai', as = 'sonokai', })
    use({ 'sainnhe/everforest', as = 'everforest', })
    use({ 'sainnhe/gruvbox-material', as = 'gruvbox-material', })
    use({ 'sainnhe/edge', as = 'edge', })


    -- Align
    use 'junegunn/vim-easy-align'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'onsails/lspkind-nvim' }
        }
    }
    use { 'neovim/nvim-lspconfig' }
    use({
        'nvimdev/lspsaga.nvim',
        after = 'nvim-lspconfig',
        config = function()
            require('lspsaga').setup({})
        end,
    })

    use { 'mfussenegger/nvim-lint' }

    -- CoPilot
    use { 'github/copilot.vim' }

    -- Zen mode
    use { 'folke/zen-mode.nvim' }

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                triggers = { "<leader>" },
                hidden = { "<silent>", "<cmd>", "<Cmd>", "^:", "^ ", "^call ", "^lua " },

                -- refer to the configuration section below
            }
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    --- writing
    use { 'preservim/vim-pencil' }
    use { 'rhysd/vim-grammarous' }
    use { 'junegunn/goyo.vim' }
    use { 'kamykn/spelunker.vim' }


    -- floating term
    use { 'voldikss/vim-floaterm' }

    -- File tree
    -- - hop up a level, ~ go home
    use { 'stevearc/oil.nvim' }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }


    use({ 'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end })
    use { 'nvim-tree/nvim-web-devicons' }

    -- Dashboard
    use { 'mhinz/vim-startify' }

    -- Tab switching
    use { 'akinsho/nvim-bufferline.lua' }

    -- Git
    use { 'lewis6991/gitsigns.nvim' }

    use {
        "antosha417/nvim-lsp-file-operations",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    }

    -- case converter
    use { "tpope/vim-abolish" }

    -- Quickfix list toggle
    use { "milkypostman/vim-togglelist" }

    -- Run commands in tmux window
    use { 'preservim/vimux' }
    use { 'tyewang/vimux-jest-test' }

    -- worktrees
    use { 'ThePrimeagen/git-worktree.nvim' }

    -- snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require 'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'luasnip' },
                    -- more sources
                },
            }
        end
    }
    use { 'saadparwaiz1/cmp_luasnip' }

    -- testing
    use { 'nvim-neotest/neotest' }

    -- annotations
    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }

    use { "ThePrimeagen/refactoring.nvim" }

    -- Jupiter
    use { 'luk400/vim-jukit', ft={'jupyter', 'py', 'ipynb'} }
    use { 'tomtom/tcomment_vim' }
    -- use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }
    -- use jupyter notebooks
    -- make block comments --
    --    use { '3rd/image.nvim' }
    --    use { 'benlubas/molten-nvim', run = ':UpdateRemotePlugins' }
    --   use { "GCBallesteros/jupytext.nvim" }
    --
    --   use {
    ---      "vhyrro/luarocks.nvim",
    --       priority = 1001,
    --       opts = {
    --           rocks = { "magick" },
    --       },
    --   }

    -- the first run will install packer and our plugins
    if packer_bootstrap then
        require("packer").sync()
        return
    end
end)

vim.cmd([[
    let g:vimwiki_list = [{
	\ 'path': '~/wiki',
	\ 'template_path': '~/wiki/.templates/',
	\ 'template_default': 'default',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/wiki/.site_html/',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.html',
    \ 'auto_tags': 1,
    \'links_space_char': '_' },
    \{
	\ 'path': '~/wiki/etsy',
	\ 'template_path': '~/wiki/.templates/',
	\ 'template_default': 'default',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/wiki/.site_html/',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.html',
    \ 'auto_tags': 1,
    \'links_space_char': '_' },
    \{
	\ 'path': '~/wiki/personal',
	\ 'template_path': '~/wiki/.templates/',
	\ 'template_default': 'default',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/wiki/.site_html/',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.html',
    \ 'auto_tags': 1,
    \'links_space_char': '_' },
    \{
	\ 'path': '~/wiki/work',
	\ 'template_path': '~/wiki/.templates/',
	\ 'template_default': 'default',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/wiki/.site_html/',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.html',
    \ 'auto_tags': 1,
    \'links_space_char': '_' }]
    let g:vimwiki_auto_header=1
]])

vim.api.nvim_create_user_command(
    'PS',
    function()
        vim.cmd("PackerSync")
    end,
    { desc = "Sync packer" }
)
