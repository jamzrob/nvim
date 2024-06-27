local keyset = vim.keymap.set
require('telescope').setup {
    defaults = {
        vimgrep_arguments = { 'rg', '--color=never',
            '--no-heading',
            '--with-filename', '--line-number',
            '--column', '--smart-case'
        },
        file_ignore_patterns = {
            "node_modules",
            ".git"
        },
        path_display = { "smart" }
    },
}
require("telescope").load_extension("git_worktree")
local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>fb', builtin.buffers, {})
keyset('n', '<leader>fh', builtin.help_tags, {})
keyset({ 'n', 'v' }, '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, {})

keyset('n', '<C-g>', builtin.git_files, {})

keyset('n', '<leader>vrw', function()
    builtin.git_files({
        prompt_title = "< nvim >",
        cwd = '~/vimwiki',
    })
end)
keyset('n', '<leader>fd', function()
    builtin.find_files({
        prompt_title = "< dotfiles (no nvim) >",
        cwd = '~/.dotfiles',
        no_ignore = true,
        hidden = true,
        file_ignore_patterns = { "nvim", "powerlevel10k", "plugins", ".git" },
        path_display = function(_, path)
            local tail = require("telescope.utils").path_tail(path)
            local filename = string.gsub(tail, ".md", "")
            return filename
        end,
    })
end)

-- Function to select the current file and two preceding directories
function _G.searchFilePath()
    local current_path = vim.fn.expand('%:p')
    local filename = vim.fn.fnamemodify(current_path, ':t')
    local file = filename:match("^(.-)%.")
    local parent_dir1 = vim.fn.fnamemodify(current_path, ':h:h:t')
    local parent_dir2 = vim.fn.fnamemodify(current_path, ':h:t')
    local search_query = string.format('%s/%s/%s', parent_dir2, parent_dir1, file)

    builtin.live_grep({
        prompt_title = 'Folder Search',
        default_text = search_query,
    })
end

vim.api.nvim_command([[command! -nargs=? SearchFilePath lua searchFilePath(<f-args>)]])
-- Create a key mapping for this function
keyset('n', '<leader>fp', ":SearchFilePath<CR>", { noremap = true, silent = true })
keyset('n', '<leader>fP', function()
    builtin.find_files({
        prompt_title = "< Packer Search >",
        cwd = '~/.local/share/nvim/site/pack/packer/start',
    })
end)

keyset('n', '<leader>fG', function()
    builtin.live_grep({
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden'
        },
    })
end)


keyset('n', '<leader>fn', function()
    builtin.find_files({
        prompt_title = "< nvim >",
        cwd = '~/.config/nvim',
        file_ignore_patterns = { "packer_compiled.lua" },
        path_display = function(_, path)
            local tail = require("telescope.utils").path_tail(path)
            local filename = string.gsub(tail, ".md", "")
            return filename
        end,
    })
end)

keyset('n', '<leader>fN', function()
    builtin.live_grep({
        prompt_title = "< nvim >",
        cwd = '~/.config/nvim',
    })
end)

keyset('n', '<leader>wg', function()
    builtin.live_grep({
        prompt_title = "< vimwiki >",
        cwd = '~/vimwiki',
        path_display = function(_, path)
            local tail = require("telescope.utils").path_tail(path)
            local filename = string.gsub(tail, ".md", "")
            return filename
        end,
        file_ignore_patterns = { "site_html", "templates" },
    })
end)

function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

keyset('v', '<leader>fg', function()
    local text = vim.getVisualSelection()
    builtin.live_grep({ default_text = text })
end)
keyset('n', '<leader>fS', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
keyset('n', '<leader>fC', function()
    vim.cmd('Colors')
end)


-- call telescope colors
vim.api.nvim_create_user_command("Colors", function()
    builtin.colorscheme({ enable_preview = true, file_ignore_patterns = { "light", "latte", "dawn", "lotus", "day" } })
end, { nargs = 0, force = true })



local wk = require("which-key")
wk.register({
    f = {

        name = "Find",
        A = { "<cmd>lua require('telescope.builtin').command_history()<CR>", "Command history" },
        C = { "Search colors" },
        D = { "Grep dotfiles" },
        H = { "<cmd>lua require('telescope.builtin').search_history()<CR>", "Search History" },
        L = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "Find Workspace Symbols" },
        N = { "Grep neovim files" },
        O = { "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", "Find Workspace Diagnostics" },
        P = { "Search packer files" },
        S = { "Search string in folders" },
        R = { "<cmd>lua require('telescope.builtin').registers()<CR>", "Search registers" },
        Y = { "<cmd>lua require('telescope.builtin').planets()<CR>", "Search planets" },
        a = { "<cmd>lua require('telescope.builtin').autocommands()<CR>", "Find autcommands" },
        b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Find Buffers" },
        c = { "<cmd>lua require('telescope.builtin').commands()<CR>", "Find Commands" },
        d = { "Search dotfiles" },
        f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
        g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Find in Project" },
        h = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Find Help" },
        l = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Find Document Symbols" },
        m = { "<cmd>lua require('telescope.builtin').marks()<CR>", "Find Marks" },
        n = { "Search neovim files" },
        o = { "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", "Find Document Diagnostics" },
        p = { "Search for imports" },
        q = { "<cmd>lua require('telescope.builtin').quickfixhistory()<CR>", "Search quickfix history" },
        r = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Find Recent Files" },
        s = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", "Find Spelling Suggestions" },
        t = { "<cmd>lua require('telescope.builtin').treesitter()<CR>", "Find Treesitter" },
        z = { "<cmd>lua require('telescope.builtin').resume()<CR>", "Resume" },
        ["?"] = { "<cmd>lua require('telescope.builtin').builtin()<CR>", "Find Telescope Help" },
    },
}, { prefix = "<leader>" })


function SourceFile()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "lua" then
        --- source the current file
        vim.cmd("luafile %")
    else
        --- source the colors.lua file
        vim.cmd("luafile ~/.config/nvim/after/plugin/colors.lua")
    end
end

vim.api.nvim_create_user_command("SourceFile", SourceFile, { nargs = 0 })

wk.register({
    ["<leader><CR>"] = { "<cmd>SourceFile<CR>", "Source File" },
})
