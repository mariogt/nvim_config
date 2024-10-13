-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#how-does-it-work
-- https://andrewcourter.substack.com/p/configure-linting-formatting-and

local cmp = require('cmp')
local lspkind = require("lspkind")
local ultisnips = require("cmp_nvim_ultisnips")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- scroll up and down the documentation window
    -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
      snippet = ultisnips.snippet,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-p>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "ultisnips" },
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- snippets
      { name = "buffer" },  -- text within current buffer
      { name = "path" },    -- file system paths
    }),
    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
  })
})
