return {
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts_extend = { "sources.default" },
    opts = {
      -- remember to enable your providers here
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = false } },
      trigger = {
        signature_help = {
          enabled = true,
        },
      },
      windows = {
        autocomplete = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          auto_show = true,
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
        signature_help = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
        ghost_text = {
          enabled = false,
        },
      },
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
