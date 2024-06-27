-- vim.keymap.set("n", "<Leader>vs", ":VimwikiVSplitLink<CR>")
--vim.keymap.set("n", "<Leader>vi", ":vs \\| :VimwikiIndex<CR>")
vim.keymap.set("n", "<Leader>wa", ":call VimwikiFindAllTasks()<CR>")
vim.keymap.set("x", "_", "+f(<leader>pldt)<C-c>", { remap = true })
vim.keymap.set("n", "<leader>wx", ":call VimwikiFindIncompleteTasks()<CR>")
vim.keymap.set("x", "<leader>-", ":VimwikiChangeSymbolTo -<CR>")
vim.keymap.set("n", "<leader>www", ":VimwikiChangeSymbolTo -<CR>")
vim.keymap.set("x", "<leader>gl", ":VimwikiChangeSymbolTo -<CR>:VimwikiToggleListItem <CR>")
vim.keymap.set("n", "<leader>gl", ":VimwikiChangeSymbolTo -<CR>:VimwikiToggleListItem <CR>")
vim.keymap.set("v", "<leader>gl", ":VimwikiChangeSymbolTo -<CR>:VimwikiToggleListItem <CR>")
vim.keymap.set("n", "<leader>ww", "<cmd>silent !tmux neww wiki -n wiki<CR>")
vim.cmd([[
nmap <Leader>www <Plug>VimwikiRemoveHeaderLevel
]])


-- vim.keymap.set("n", "-", function() return "<plug>VimwikiNormalizeLink" end, { expr = true, remap = true})
vim.g.vimwiki_folder = 'expr'

-- configuration
local config = {
    projectsFolder = '/$HOME/my-dev', --full path without ~
    vimwikiRoot = '/$HOME/wiki',
    maxDepth = 3,
    ignoreFolders = { 'node_modules', '.git' },
    rootWikiFolder = 'wiki',
    wikiConfig = { syntax = 'markdown', ext = 'md' }
}

-- function to search project folders for root wiki folders (returns system list)
local function getNonProjectWikis()
    local command = 'ls -d ' .. config.vimwikiRoot ..
        '/*/'
    local list = vim.api.nvim_call_function('systemlist', { command })
    return list
end

function GetFileName(url)
    local name = url:match("^.+/(.+)$")
    name = name:sub(1, -2)
    return name
end

local function tableConcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]:sub(1, -2)
    end
    return t1
end


-- store original vimwiki_list config, we will need it later
-- !!!make sure vimwiki plugin is loaded before running this!!!
if vim.g.vimwiki_list == nil then
    error('VimWiki not loaded yet! make sure VimWiki is initialized before my-projects-wiki')
else
    _G.vimwiki_list_orig = vim.fn.copy(vim.g.vimwiki_list) or {}
end

-- function to update g:vimwiki_list config item from list of subfolder names (append project wikis)
--   this way, orginal <Leader>ws will get new project wikis in the list and also keep ones from config
local function updateVimwikiList(folders)
    local new_list = {}
    for _, f in ipairs(folders) do
        local path = ""
        if string.find(f, config.rootWikiFolder) then
            path = f
        else
            path = f
        end
        local filename = GetFileName(path)
        local item = {
            path = path,
            syntax = config.wikiConfig.syntax,
            ext = config.wikiConfig.ext,
            auto_tags = 1,
            path_html = '~/vimwiki_html/' .. filename,
            custom_wiki2html = '~/wiki/wiki2html.sh',
            generated_links_caption = 1,
            links_space_char = '_',
            diary_rel_path = "../daily/"

        }
        table.insert(new_list, item)
    end
    vim.g.vimwiki_list = new_list
    vim.api.nvim_call_function('vimwiki#vars#init', {})
end


-- function to search project folders for root wiki folders (returns system list)
local function searchForWikis()
    local command = 'find ' .. config.projectsFolder ..
        ' -maxdepth ' .. config.maxDepth
    if #config.ignoreFolders > 0 then command = command .. " \\(" end
    for _, f in ipairs(config.ignoreFolders) do
        command = command .. " -path '*/" .. f .. "/*' -prune"
        if next(config.ignoreFolders, _) == nil then
            command = command .. " \\) -o"
        else
            command = command .. " -o"
        end
    end
    command = command .. ' -type d -name ' .. config.rootWikiFolder
    command = command .. ' -print | '
    command = command .. ' sed s#' .. config.projectsFolder .. '##'
    local list = vim.api.nvim_call_function('systemlist', { command })
    return list
end

-- wrapper for Vimwiki's goto_index() to bypass :VimWikiUISelect and use FZF instead
-- if wiki is passed to the function, index page is opened directly, bypassing FZF
function _G.ProjectWikiOpen(name)
    -- show fzf wiki search if no wiki passed
    if not name then
        local wikis = searchForWikis()
        ;
        local options = {
            sink = function(selected) ProjectWikiOpen(selected) end,
            source = wikis,
            options = '--ansi --reverse --no-preview --delimiter / --with-nth 2',
            window = {
                width = 0.3,
                height = 0.6,
                border = 'sharp'
            }
        }
        vim.fn.call('fzf#run', { options })
    else
        for i, v in ipairs(vim.g.vimwiki_list) do
            if v.path == name or v.path == config.projectsFolder .. name then
                vim.fn.call('vimwiki#base#goto_index', { i })
                return
            end
        end
        print("Error. Selected project wiki not found")
    end
end

function _G.MyWikiOpen(name)
    -- show fzf wiki search if no wiki passed
    if not name then
        local non = getNonProjectWikis()
        updateVimwikiList(non)
        ;
        local options = {
            sink = function(selected) MyWikiOpen(selected) end,
            source = non,
            options = '--ansi --reverse --no-preview --delimiter / --with-nth 6',
            window = {
                width = 0.3,
                height = 0.6,
                border = 'sharp'
            }
        }
        vim.fn.call('fzf#run', { options })
    else
        for i, v in ipairs(vim.g.vimwiki_list) do
            if v.path == name or v.path == config.projectsFolder .. name then
                vim.fn.call('vimwiki#base#goto_index', { i })
                return;
            end
        end
        print("Error. Selected project wiki not found")
    end
end

-- add commands
vim.api.nvim_command([[command! -nargs=? ProjectWikiOpen lua ProjectWikiOpen(<f-args>)]])
vim.api.nvim_command([[command! -nargs=? MyWikiOpen lua MyWikiOpen(<f-args>)]])

-- add keybindings
vim.api.nvim_set_keymap("n", "<Leader>ww", ":VimwikiIndex 1<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>wt", ":ProjectWikiOpen<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>wp", ":MyWikiOpen<CR>", { noremap = true })
