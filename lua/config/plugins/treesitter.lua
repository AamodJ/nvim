return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    -- local ensure_installed = {
    --   -- shell
    --   'bash',
    --   'zsh',
    --   -- programming
    --   'c',
    --   'python',
    --   'lua',
    --   -- docs
    --   'diff',
    --   'html',
    --   'luadoc',
    --   'markdown',
    --   'markdown_inline',
    --   'query',
    --   'vim',
    --   'vimdoc',
    -- }
    --
    -- We install the unstable tier with 314 parsers
    -- Better to install this than manually specify each parser
    -- Small overhead. The 'all' tier takes up about 230MB of disk space
    -- We can spare that much space
    require('nvim-treesitter').install 'unstable'

    -- treesitter based folding
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldminlines = 20

    -- treesitter based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
}
