local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  {
    "Saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts_extend = { "sources.default", "sources.cmdline" },
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
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-N>"] = { "select_next", "show" },
        ["<C-P>"] = { "select_prev", "show" },
        ["<C-J>"] = { "select_next", "fallback" },
        ["<C-K>"] = { "select_prev", "fallback" },
        ["<C-U>"] = { "scroll_documentation_up", "fallback" },
        ["<C-D>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            elseif cmp.snippet_active { direction = 1 } then
              return cmp.snippet_forward()
            elseif has_words_before() then
              return cmp.show()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            elseif cmp.snippet_active { direction = -1 } then
              return cmp.snippet_backward()
            end
          end,
          "fallback",
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
        menu = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
    },
    specs = {
      {
        "folke/lazydev.nvim",
        optional = true,
        specs = {
          {
            "Saghen/blink.cmp",
            opts = function(_, opts)
              if pcall(require, "lazydev.integrations.blink") then
                return require("astrocore").extend_tbl(opts, {
                  sources = {
                    -- add lazydev to your completion providers
                    default = { "lazydev" },
                    providers = {
                      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                    },
                    min_keyword_length = function(ctx)
                      if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 2 end
                      return 0
                    end,
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
