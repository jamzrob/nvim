local preset = {
    float_border = 'rounded',
    call_servers = 'local',
    configure_diagnostics = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = {
        preserve_mappings = false,
        omit = {},
    },
    manage_nvim_cmp = {
        set_sources = 'recommended',
        set_basic_mappings = true,
        set_extra_mappings = false,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
    },
}

local lsp = require('lsp-zero').preset(preset)

lsp.ensure_installed({
    "grammarly",
    "pylsp",
    "gopls",
    'tsserver',
    'vtsls',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'intelephense',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})



lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    --  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.cmd([[
vnoremap / "zy/<C-r>z<CR>
]])
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['rust_analyzer'] = { 'rust' },
        ['ruby'] = { 'solargraph' }
    }
})



vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.ts", "*.rb", "*.lua", "*.go" },
    desc = "Auto-format files after saving",
    callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end,
})

vim.cmd([[autocmd BufWritePost *.html.erb silent! !prettier %]])
vim.cmd([[autocmd BufWritePost *.html silent! !prettier %]])
vim.cmd([[autocmd BufWritePost *.ts silent! EslintFixAll]])
vim.cmd([[autocmd BufWritePost *.tsx EslintFixAll]])
vim.cmd([[autocmd BufWritePost *.jsx EslintFixAll]])
vim.cmd([[autocmd BufWritePost *.js EslintFixAll]])
vim.cmd([[autocmd BufWritePost *.py silent! !black %]])

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

vim.cmd([[


" add \ to filenames so that we can get whole namespaced filenames
set isfname+=\
" make 'gf' Etsyweb aware
set includeexpr=substitute(substitute(substitute(v:fname,'_','/','g'),'\\\','/','g'),'Etsy/Web/','','g').'.php'
set path =
            \~/development/Etsyweb/,
            \~/development/Etsyweb/phplib/EtsyModel,
            \~/development/Etsyweb/phplib,
            \~/development/Etsyweb/templates,
            \~/development/Etsyweb/htdocs,
            \~/development/Etsyweb/phplib/Api,
            \~/development/Etsyweb/phplib/Api/Resource,
            \~/development/Etsyweb/htdocs/assets/js,
            \~/development/Etsyweb/htdocs/assets/css,
            \~/development/Etsyweb/htdocs_arizona/phplib
set suffixesadd=.tpl,.php,.js,.scss,.ts
]])

require 'lspconfig'.pylsp.setup {}
require 'lspconfig'.htmx.setup {}
