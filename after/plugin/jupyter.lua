vim.cmd([[
let g:jukit_shell_cmd = 'ipython3'
"    - Specifies the command used to start a shell in the output split. Can also be an absolute path. Can also be any other shell command, e.g. `R`, `julia`, etc. (note that output saving is only possible for ipython)
let g:jukit_terminal = 'nvimterm'
"   - Terminal to use. Can be one of '', 'kitty', 'vimterm', 'nvimterm' or 'tmux'. If '' is given then will try to detect terminal (though this might fail, in which case it simply defaults to 'vimterm' or 'nvimterm' - depending on the output of `has("nvim")`)
let g:jukit_auto_output_hist = 0
"   - If set to 1, will create an autocmd with event `CursorHold` to show saved ipython output of current cell in output-history split. Might slow down (n)vim significantly, you can use `set updatetime=<number of milliseconds>` to control the time to wait until CursorHold events are triggered, which might improve performance if set to a higher number (e.g. `set updatetime=1000`).
let g:jukit_use_tcomment = 1
"   - Whether to use tcomment plugin (https://github.com/tomtom/tcomment_vim) to comment out cell markers. If not, then cell markers will simply be prepended with `g:jukit_comment_mark`
let g:jukit_comment_mark = '#'
"   - See description of `g:jukit_use_tcomment` above
let g:jukit_mappings = 0
"   - If set to 0, none of the default function mappings (as specified further down) will be applied
let g:jukit_mappings_ext_enabled = "*"
"   - String or list of strings specifying extensions for which the mappings will be created. For example, `let g:jukit_mappings_ext_enabled=['py', 'ipynb']` will enable the mappings only in `.py` and `.ipynb` files. Use `let g:jukit_mappings_ext_enabled='*'` to enable them for all files.
let g:jukit_notebook_viewer = 'jupyter-notebook'
"   - Command to open .ipynb files, by default jupyter-notebook is used. To use e.g. vs code instead, you could set this to `let g:jukit_notebook_viewer = 'code'`
let g:jukit_convert_overwrite_default = -1
"   - Default setting when converting from .ipynb to .py or vice versa and a file of the same name already exists. Can be of [-1, 0, 1], where -1 means no default (i.e. you'll be prompted to specify what to do), 0 means never overwrite, 1 means always overwrite
let g:jukit_convert_open_default = 1
"   - Default setting for whether the notebook should be opened after converting from .py to .ipynb. Can be of [-1, 0, 1], where -1 means no default (i.e. you'll be prompted to specify what to do), 0 means never open, 1 means always open
let g:jukit_file_encodings = 'utf-8'
"   - Default encoding for reading and writing to files in the python helper functions
let g:jukit_venv_in_output_hist = 1
"   - Whether to also use the provided terminal command for the output history split when starting the splits using the JukitOUtHist command. If 0, the provided terminal command is only used in the output split, not in the output history split.
let g:jukit_inline_plotting = 1
nnoremap <localleader>os :call jukit#splits#output()<cr>
"   - Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
nnoremap <localleader>ts :call jukit#splits#term()<cr>
"   - Opens a new output window without executing any command
nnoremap <localleader>hs :call jukit#splits#history()<cr>
"   - Opens a new output-history window, where saved ipython outputs are displayed
nnoremap <localleader>ohs :call jukit#splits#output_and_history()<cr>
"   - Shortcut for opening output terminal and output-history
nnoremap <localleader>hd :call jukit#splits#close_history()<cr>
"   - Close output-history window
nnoremap <localleader>od :call jukit#splits#close_output_split()<cr>
"   - Close output window
nnoremap <localleader>ohd :call jukit#splits#close_output_and_history(1)<cr>
"   - Close both windows. Argument: Whether or not to ask you to confirm before closing.
nnoremap <localleader>so :call jukit#splits#show_last_cell_output(1)<cr>
"   - Show output of current cell (determined by current cursor position) in output-history window. Argument: Whether or not to reload outputs if cell id of outputs to display is the same as the last cell id for which outputs were displayed
nnoremap <localleader>j :call jukit#splits#out_hist_scroll(1)<cr>
"   - Scroll down in output-history window. Argument: whether to scroll down (1) or up (0)
nnoremap <localleader>k :call jukit#splits#out_hist_scroll(0)<cr>
"   - Scroll up in output-history window. Argument: whether to scroll down (1) or up (0)
nnoremap <localleader>ah :call jukit#splits#toggle_auto_hist()<cr>
"   - Create/delete autocmd for displaying saved output on CursorHold. Also, see explanation for `g:jukit_auto_output_hist`
nnoremap <localleader>sl :call jukit#layouts#set_layout()<cr>
"   - Apply layout (see `g:jukit_layout`) to current splits - NOTE: it is expected that this function is called from the main file buffer/split
nnoremap <localleader><space> :call jukit#send#section(0)<cr>
"   - Send code within the current cell to output split (also saves the output if ipython is used and `g:jukit_save_output==1`). Argument: if 1, will move the cursor to the next cell below after sending the code to the split, otherwise cursor position stays the same.
nnoremap <localleader><cr> :call jukit#send#line()<cr>
"   - Send current line to output split
vnoremap <localleader><cr> :<C-U>call jukit#send#selection()<cr>
"   - Send visually selected code to output split
nnoremap <localleader>cc :call jukit#send#until_current_section()<cr>
"   - Execute all cells until the current cell
nnoremap <localleader>all :call jukit#send#all()<cr>
"   - Execute all cells
nnoremap <localleader>co :call jukit#cells#create_below(0)<cr>
"   - Create new code cell below. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <localleader>cO :call jukit#cells#create_above(0)<cr>
"   - Create new code cell above. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <localleader>ct :call jukit#cells#create_below(1)<cr>
"   - Create new textcell below. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <localleader>cT :call jukit#cells#create_above(1)<cr>
"   - Create new textcell above. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <localleader>cd :call jukit#cells#delete()<cr>
"   - Delete current cell
nnoremap <localleader>cs :call jukit#cells#split()<cr>
"   - Split current cell (saved output will then be assigned to the resulting cell above)
nnoremap <localleader>cM :call jukit#cells#merge_above()<cr>
"   - Merge current cell with the cell above
nnoremap <localleader>cm :call jukit#cells#merge_below()<cr>
"   - Merge current cell with the cell below
nnoremap <localleader>ck :call jukit#cells#move_up()<cr>
"   - Move current cell up
nnoremap <localleader>cj :call jukit#cells#move_down()<cr>
"   - Move current cell down
nnoremap <localleader>J :call jukit#cells#jump_to_next_cell()<cr>
"   - Jump to the next cell below
nnoremap <localleader>K :call jukit#cells#jump_to_previous_cell()<cr>
"   - Jump to the previous cell above
nnoremap <localleader>ddo :call jukit#cells#delete_outputs(0)<cr>
"   - Delete saved output of current cell. Argument: Whether to delete all saved outputs (1) or only saved output of current cell (0)
nnoremap <localleader>dda :call jukit#cells#delete_outputs(1)<cr>
"   - Delete saved outputs of all cells. Argument: Whether to delete all saved outputs (1) or only saved output of current cell (0)
nnoremap <localleader>np :call jukit#convert#notebook_convert("jupyter-notebook")<cr>
"   - Convert from ipynb to py or vice versa. Argument: Optional. If an argument is specified, then its value is used to open the resulting ipynb file after converting script.
nnoremap <localleader>ht :call jukit#convert#save_nb_to_file(0,1,'html')<cr>
"   - Convert file to html (including all saved outputs) and open it using the command specified in `g:jukit_html_viewer'. If `g:jukit_html_viewer` is not defined, then will default to `g:jukit_html_viewer='xdg-open'`. Arguments: 1.: Whether to rerun all cells when converting 2.: Whether to open it after converting 3.: filetype to convert to
nnoremap <localleader>rht :call jukit#convert#save_nb_to_file(1,1,'html')<cr>
"   - same as above, but will (re-)run all cells when converting to html
nnoremap <localleader>pd :call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>
"   - Convert file to pdf (including all saved outputs) and open it using the command specified in `g:jukit_pdf_viewer'. If `g:jukit_pdf_viewer` is not defined, then will default to `g:jukit_pdf_viewer='xdg-open'`. Arguments: 1.: Whether to rerun all cells when converting 2.: Whether to open it after converting 3.: filetype to convert to. NOTE: If the function doesn't work there may be issues with your nbconvert or latex version - to debug, try converting to pdf using `jupyter nbconvert --to pdf --allow-errors --log-level='ERROR' --HTMLExporter.theme=dark </abs/path/to/ipynb> && xdg-open </abs/path/to/pdf>` in your terminal and check the output for possible issues.
nnoremap <localleader>rpd :call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>
"   - same as above, but will (re-)run all cells when converting to pdf. NOTE: If the function doesn't work there may be issues with your nbconvert or latex version - to debug, try converting to pdf using `jupyter nbconvert --to pdf --allow-errors --log-level='ERROR' --HTMLExporter.theme=dark </abs/path/to/ipynb> && xdg-open </abs/path/to/pdf>` in your terminal and check the output for possible issues.

]])

--[[  Molten
vim.keymap.set("n", "<localleader>r", ":MagmaEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<localleader>rr", ":MagmaEvaluateLine<CR>", { desc = "evaluate line", silent = true })
vim.keymap.set("v", "<localleader>r", ":<C-u>MagmaEvaluateVisual<CR>gv",
    { desc = "execute visual selection", silent = true })
vim.keymap.set("n", "<localleader>rc", ":MagmaReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set("n", "<localleader>rd", ":MagmaDelete<CR>", { desc = "delete Magma cell", silent = true })
vim.keymap.set("n", "<localleader>ro", ":MagmaShowOutput<CR>", { desc = "open output window", silent = true })
let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "none"
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })

vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { desc = "execute visual selection", silent = true })
vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

-- if you work with html outputs:
vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })

require("luarocks-nvim").setup({
    rocks = { "magick" },
})


-- default config
require("image").setup({
    backend = "kitty",
    max_width = 100,
    max_height = 12,
    max_width_window_percentage = math.huge,
    max_height_window_percentage = math.huge,
    window_overlap_clear_enabled = true,                                      -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
})


require("jupytext").setup({})

require("nvim-treesitter.configs").setup({
    -- ... other ts config
    textobjects = {
        move = {
            enable = true,
            set_jumps = false, -- you can change this if you want.
            goto_next_start = {
                --- ... other keymaps
                ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
                --- ... other keymaps
                ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
        },
        select = {
            enable = true,
            lookahead = true, -- you can change this if you want
            keymaps = {
                --- ... other keymaps
                ["ib"] = { query = "@code_cell.inner", desc = "in block" },
                ["ab"] = { query = "@code_cell.outer", desc = "around block" },
            },
        },
        swap = { -- Swap only works with code blocks that are under the same
            -- markdown header
            enable = true,
            swap_next = {
                --- ... other keymap
                ["<leader>sbl"] = "@code_cell.outer",
            },
            swap_previous = {
                --- ... other keymap
                ["<leader>sbh"] = "@code_cell.outer",
            },
        },
    }
})


require("lspconfig")["pyright"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedExpression = "none",
                },
            },
        },
    },
})


-- change the configuration when editing a python file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.py",
    callback = function(e)
        if string.match(e.file, ".otter.") then
            return
        end
        if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("virt_text_output", false)
        else
            vim.g.molten_virt_lines_off_by_1 = false
            vim.g.molten_virt_text_output = false
        end
    end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.qmd", "*.md", "*.ipynb" },
    callback = function(e)
        if string.match(e.file, ".otter.") then
            return
        end
        if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
            vim.fn.MoltenUpdateOption("virt_text_output", true)
        else
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_virt_text_output = true
        end
    end,
})


]]
--
