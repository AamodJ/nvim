return {
  'vimwiki/vimwiki',
  init = function()
    vim.g.vimwiki_key_mappings = {
      -- all_maps = 0,
      -- global = 0,
      links = 0,
    }
    vim.g.vimwiki_list = {
      {
        path = '$HOME/docs/dba_training/wiki/',
        syntax = 'default',
        ext = '.wiki',
      },
    }
  end,
  config = function()
    local vimwiki_group = vim.api.nvim_create_augroup('VimwikiAutoTOC', { clear = true })

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vimwiki_group,
      pattern = '*.wiki',
      callback = function()
        local filename = vim.fn.expand '%:t'
        if vim.bo.filetype == 'vimwiki' and filename ~= 'index.wiki' then
          pcall(vim.cmd, 'VimwikiTOC')
        end
      end,
    })

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { desc = 'Vimwiki: ' .. desc })
    end

    --> Link following keybinds
    map('<return>', '<cmd>VimwikiFollowLink<cr>', 'Follow Link')
    map('<leader><return>', '<cmd>VimwikiGoBackLink<cr>', 'Go Back Link')
    map('<leader>vh', '<cmd>VimwikiSplitLink<cr>', 'Split [H]orizontal and Follow Link')
    map('<leader>v<return>', '<cmd>VimwikiVSplitLink<cr>', 'Split [V]ertical and Follow Link')
    map('<leader>n', '<cmd>VimwikiNextLink<cr>', '[N]ext Link')
    map('<leader>p', '<cmd>VimwikiPrevLink<cr>', '[P]revious Link')
    --
    -- map('<leader>vc', '<cmd>VimwikiTOC<cr>', 'Create Table of [C]ontents')
    -- map('<leader>vr', '<cmd>VimwikiRenameFile<cr>', '[R]ename Current Wiki Page')
    -- map('<leader>vt', '<cmd>VimwikiTable<cr>', '[T]able')
    -- map('<leader>vh', '<cmd>VimwikiTableMoveColumnLeft<cr>', 'Table Move Column Left [H]')
    -- map('<leader>vl', '<cmd>VimwikiTableMoveColumnRight<cr>', 'Table Move Column Right [L]')
    -- map('<leader>vb', '<cmd>VimwikiBacklinks<cr>', 'All [B]acklinks')
    -- map('<leader>vw', '<cmd>VimwikiIndex<cr>', 'Open [W]iki Index')
  end,
}
