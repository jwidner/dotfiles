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
    'https://github.com/junegunn/fzf',
    'https://github.com/junegunn/fzf.vim',

    {
        src = 'https://github.com/neoclide/coc.nvim',
        version = 'release',
    },

})

require('solarized').set()
