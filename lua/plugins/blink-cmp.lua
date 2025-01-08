local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---@type function?
local icon_provider

local function get_icon(CTX)
  if not icon_provider then
    local base = function(ctx) ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind end
    local _, mini_icons = pcall(require, "mini.icons")
    if _G.MiniIcons then
      icon_provider = function(ctx)
        base(ctx)
        if ctx.item.source_name == "LSP" then
          local item_doc, color_item = ctx.item.documentation, nil
          if item_doc then
            local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
            color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
          end
          local icon, hl = mini_icons.get("lsp", ctx.kind or "")
          if icon then
            ctx.kind_icon = icon
            ctx.kind_hl_group = hl
          end
          if color_item and color_item.abbr and color_item.abbr_hl_group then
            ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
          end
        elseif ctx.item.source_name == "Path" then
          ctx.kind_icon, ctx.kind_hl_group = mini_icons.get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
        end
      end
    end
    local lspkind_avail, lspkind = pcall(require, "lspkind")
    if lspkind_avail then
      icon_provider = function(ctx)
        base(ctx)
        if ctx.item.source_name == "LSP" then
          local item_doc, color_item = ctx.item.documentation, nil
          if item_doc then
            local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
            color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
          end
          local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
          if icon then ctx.kind_icon = icon end
          if color_item and color_item.abbr and color_item.abbr_hl_group then
            ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
          end
        end
      end
    end
    icon_provider = base
  end
  icon_provider(CTX)
end

return {
  {
    "Saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets", "mikavilpas/blink-ripgrep.nvim" },
    opts_extend = { "sources.default", "sources.cmdline" },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "ripgrep" },

        providers = {
          -- 👇🏻👇🏻 add the ripgrep provider config below
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- For many options, see `rg --help` for an exact description of
              -- the values that ripgrep expects.

              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- The number of lines to show around each match in the preview
              -- (documentation) window. For example, 5 means to show 5 lines
              -- before, then the match, and another 5 lines after the match.
              context_size = 5,

              -- The maximum file size of a file that ripgrep should include in
              -- its search. Useful when your project contains large files that
              -- might cause performance issues.
              -- Examples:
              -- "1024" (bytes by default), "200K", "1M", "1G", which will
              -- exclude files larger than that size.
              max_filesize = "1M",

              -- Specifies how to find the root of the project where the ripgrep
              -- search will start from. Accepts the same options as the marker
              -- given to `:h vim.fs.root()` which offers many possibilities for
              -- configuration. If none can be found, defaults to Neovim's cwd.
              --
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = ".git",

              -- The casing to use for the search in a format that ripgrep
              -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
              -- available options ripgrep supports, but you can try
              -- "--case-sensitive" or "--smart-case".
              search_casing = "--ignore-case",

              -- (advanced) Any additional options you want to give to ripgrep.
              -- See `rg -h` for a list of all available options. Might be
              -- helpful in adjusting performance in specific situations.
              -- If you have an idea for a default, please open an issue!
              --
              -- Not everything will work (obviously).
              additional_rg_options = {},

              -- When a result is found for a file whose filetype does not have a
              -- treesitter parser installed, fall back to regex based highlighting
              -- that is bundled in Neovim.
              fallback_to_regex_highlighting = true,

              -- Show debug information in `:messages` that can help in
              -- diagnosing issues with the plugin.
              debug = false,
            },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
          },
        },
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
          "select_next",
          "snippet_forward",
          function(cmp)
            if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          function(cmp)
            if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
          end,
          "fallback",
        },
      },
      enabled = function() return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false end,
      completion = {
        list = { selection = { preselect = true, auto_insert = true } },
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
          auto_show = function(ctx) return ctx.mode ~= "cmdline" end,

          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  get_icon(ctx)
                  return ctx.kind_icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  get_icon(ctx)
                  return ctx.kind_hl_group
                end,
              },
            },
          },
        },
      },
    },
    specs = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        opts = function(_, opts)
          opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)

          -- disable AstroLSP signature help if `blink.cmp` is providing it
          local blink_opts = require("astrocore").plugin_opts "blink.cmp"
          if vim.tbl_get(blink_opts, "signature", "enabled") == true then
            if not opts.features then opts.features = {} end
            opts.features.signature_help = false
          end
        end,
      },
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
    },
  },
}
