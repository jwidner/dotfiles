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
    'https://github.com/tpope/vim-rhubarb',  -- GitHub support for fugitive
    'https://github.com/lewis6991/gitsigns.nvim',

    'https://github.com/ibhagwan/fzf-lua',

    'https://github.com/ludovicchabant/vim-gutentags',
    'https://github.com/neovim/nvim-lspconfig',

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

-- lsp
--
-- navigation
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

-- diagnostics
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- lsp servers
--
-- <https://microsoft.github.io/language-server-protocol/implementors/servers/>
vim.lsp.enable('clangd')
