return {
  "hrsh7th/nvim-cmp", -- Main completion plugin
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",       -- LSP source for nvim-cmp
    "L3MON4D3/LuaSnip",           -- Snippet engine
    "saadparwaiz1/cmp_luasnip",   -- Snippets source for nvim-cmp
    "hrsh7th/cmp-cmdline", -- Command-line source for nvim-cmp
    "hrsh7th/cmp-path",    -- Path completion (useful for command-line)
    "kdheepak/cmp-latex-symbols", -- LaTeX symbols completion
  },
  config = function()
    -- Import required modules
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load VSCode-style snippets for LuaSnip
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load custom LuaSnip snippets
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

    -- nvim-cmp configuration
    cmp.setup({
      snippet = {
        -- Snippet engine configuration
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll up in documentation
        ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- Scroll down in documentation
        ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion menu
        ["<C-e>"] = cmp.mapping.abort(),         -- Close completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item() -- Navigate to the next item
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump() -- Expand snippet or jump forward
          else
            fallback() -- Default behavior
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item() -- Navigate to the previous item
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1) -- Jump backward in snippet
          else
            fallback() -- Default behavior
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP source
        { name = "luasnip" },  -- Snippets source
        { name = "cmp_latex_symbols" }, -- LaTeX symbols source
      }, {
        { name = "buffer" },   -- Buffer source
        { name = "path" },     -- Path source
      }),
    })

    -- Command-line completion (optional)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "path" },
        { name = "cmdline" },
      },
    })
  end,
}

