return {
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts_extend = { "sources.default" },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
      },
      keymap = {
        ["<Tab>"] = { "select_next", "fallback" }, -- snippets
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
        ["<C-l>"] = { "show", "hide", "fallback" },
        ["<C-_>"] = { "cancel", "fallback" },
        ["<C-Space>"] = { "show_documentation", "hide_documentation", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      },
      completion = {
        list = { selection = "auto_insert" },
        accept = { auto_brackets = { enabled = false } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
        menu = {
          draw = { columns = { { "label", "label_description", gap = 1 }, { "kind" } } },
        },
      },
      -- completion = {
      --   documentation = {
      --     auto_show = true,
      --     window = {
      --       border = "rounded",
      --       winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      --     },
      --   },
      -- },
    },
    specs = {
      {
        "folke/lazydev.nvim",
        specs = {
          {
            "Saghen/blink.cmp",
            opts = function(_, opts)
              if pcall(require, "lazydev.integrations.blink") then
                return require("astrocore").extend_tbl(opts, {
                  sources = {
                    default = { "lazydev" },
                    providers = {
                      -- dont show LuaLS require statements when lazydev has items
                      lsp = { fallbacks = { "lazydev" } },
                      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
                    },
                  },
                })
              end
            end,
          },
        },
      },
      -- disable built in completion plugins
      { "hrsh7th/nvim-cmp", enabled = false },
      { "rcarriga/cmp-dap", enabled = false },
      { "L3MON4D3/LuaSnip", enabled = false },
      { "petertriho/cmp-git", enabled = false },
      { "onsails/lspkind.nvim", enabled = false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function(_, opts)
      local lspconfig = require "lspconfig"
      for server, config in pairs(opts.servers or {}) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
