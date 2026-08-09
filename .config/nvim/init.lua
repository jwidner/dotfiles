vim.opt.runtimepath:prepend(vim.fn.expand("~/.vim"))
vim.opt.runtimepath:append(vim.fn.expand("~/.vim/after"))

vim.opt.packpath = vim.opt.runtimepath:get()

vim.cmd.source(vim.fn.expand("~/.vimrc"))

vim.pack.add({
    'https://github.com/shaunsingh/solarized.nvim',

    'https://github.com/tpope/vim-commentary',
    'https://github.com/tpope/vim-surround',
    'https://github.com/godlygeek/tabular',
    'https://github.com/michaeljsmith/vim-indent-object',

    'https://github.com/tpope/vim-fugitive',
    'https://github.com/lewis6991/gitsigns.nvim',

    'https://github.com/ibhagwan/fzf-lua',

    {
        src = 'https://github.com/neoclide/coc.nvim',
        version = 'release',
    },
    'https://github.com/ludovicchabant/vim-gutentags',

})

require('solarized').set()
require('gitsigns').setup {}
require('fzf-lua').setup {
    grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    },
}

-- keybindings
--
-- fzf-lua
vim.keymap.set('n', '<Leader>f', FzfLua.files)
vim.keymap.set('n', '<Leader>g', FzfLua.git_files)
vim.keymap.set('n', '<Leader>b', FzfLua.buffers)
vim.keymap.set('n', '<Leader>t', FzfLua.tags)
vim.keymap.set('n', '<Leader>?', FzfLua.history)
vim.keymap.set('n', '<Leader>s', FzfLua.grep_project)
