return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local ensure_installed = {
      -- shell
      'bash',
      'zsh',
      -- programming
      'c',
      'python',
      'lua',
      'nix',
      -- docs
      'diff',
      'html',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    }

    -- It's recommended to install the unstable list with over 314 parsers
    -- But installing them might fail. We don't want to keep trying the
    -- reinstall everytime nvim opens. So we ensure only few installed and
    -- leave it to the user to install the rest
    require('nvim-treesitter').install(ensure_installed)

    -- treesitter based folding
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldminlines = 500

    -- treesitter based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
}
