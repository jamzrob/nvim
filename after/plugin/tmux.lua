vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<cr>", {noremap = false, silent=true })
vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<cr>", {noremap = false, silent=true })
vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<cr>", {noremap = false, silent=true })
vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<cr>", {noremap = false, silent=true })
vim.keymap.set("n", "<c-\\>", ":TmuxNavigatePrevious<cr>", {noremap = false, silent=true })


vim.cmd([[
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction
]])
