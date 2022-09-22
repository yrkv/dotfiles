require('core.plugins')
require('impatient')

require('configs.cmp')
require('configs.lsp')

vim.cmd('colorscheme gruvbox')

vim.opt.termguicolors = true
require('feline').setup({ theme = 'default' })

require('gitsigns').setup()

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}


require('mason').setup()
require('which-key').setup()
require('colorizer').setup()

vim.cmd('highlight IndentBlanklineChar guifg=#444444 gui=nocombine')
require("indent_blankline").setup {
    --show_trailing_blankline_indent = false,
    -- for example, context is off by default, use this to turn it on
    --show_current_context = true,
    --show_current_context_start = true,
}


vim.opt.clipboard = 'unnamed'


vim.opt.modeline = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.scrolloff = 5

vim.opt.lazyredraw = true


-- When editing a file, always jump to the last known cursor position.
vim.cmd([[
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
]])


vim.api.nvim_set_keymap(
  "",
  "<leader>y",
  "\"*y",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "",
  "<leader>p",
  "\"*p",
  { noremap = true, silent = true }
)

--vim.api.nvim_set_keymap(
--  "v", "<leader>y",
--  ":w !xclip -i -sel clipboard<CR><CR>",
--  { noremap = true, silent = true }
--)
--
--vim.api.nvim_set_keymap(
--  "",
--  "<leader>p",
--  ":r !xclip -o -sel clipboard<CR><CR>",
--  { noremap = true, silent = true }
--)

