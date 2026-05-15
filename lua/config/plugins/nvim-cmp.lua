return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      version = '*',
      build = 'make install_jsregexp',
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local ls = require 'luasnip'
    local types = require 'luasnip.util.types'
    -- Snippet creator
    -- s(<trigger>, <nodes>)
    local s = ls.snippet
    -- Formatter node. Takes a format string and list of nodes
    -- fmt(<fmt_string>, { ... nodes } )
    local fmt = require('luasnip.extras.fmt').fmt
    -- Insert node
    -- Takes position like $1 and optionally some default text
    -- i(<position>, [default_text])
    local i = ls.insert_node
    local t = ls.text_node
    -- Repeats a node at position
    -- rep(<position>)
    local rep = require('luasnip.extras').rep

    ls.config.setup {
      -- This tells luasnip to remember our last snippet, allowing you to jump to it even when you move outside of it
      history = true,
      -- Makes your snippets update as you type
      updateevents = 'TextChanged,TextChangedI',
      -- autosnippetts
      -- enable_autosnippets = true,

      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_next = { { '<-', 'Error' } },
          },
        },
      },
    }

    -- Actual snippets
    ls.add_snippets('vimwiki', {
      s('cc', {
        t '{{{class: "brush: ',
        i(1),
        t { '"', '' },
        i(2),
        t { '', '}}}', '' },
        i(0),
      }),
    })
    ls.add_snippets('python', {
      s('fn', {
        t 'def ',
        i(1),
        t '(',
        i(2),
        t ') -> ',
        i(3),
        t { ':', '\t' },
        i(4),
        t ' = ',
        i(5),
        t { '', '\t' },
        i(6),
        t { '', '' },
        t { '\treturn ' },
        rep(4),
        t { '', '' },
        t { '', '' },
        i(0),
      }),
      -- s(
      --   'cc',
      --   fmt [[
      --   {{{{{{class: "brush: {}"
      --   {}
      --   }}}}}}
      --   {}
      --   ]],
      --   { i(1), i(2), i(0) }
      -- ),
    })

    cmp.setup {
      snippet = {
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },

        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        --['<CR>'] = cmp.mapping.confirm { select = true },
        --['<Tab>'] = cmp.mapping.select_next_item(),
        --['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if ls.locally_jumpable(-1) then
            ls.jump(-1)
          end
        end, { 'i', 's' }),
        ['<C-j>'] = cmp.mapping(function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
  end,
}
