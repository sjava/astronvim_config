return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      for _, source in ipairs(opts.sources) do
        if source.name == "buffer" then
          source.option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
          }
        end
      end
      return opts
    end,
  },
  {
    "sjava/yode-nvim",
    event = "User AstroFile",
    -- config = function() require("yode-nvim").setup {} end,
  },
  {
    "h-hg/fcitx.nvim",
    event = "User AstroFile",
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    event = "User AstroFile",
    config = function()
      require("windows").setup {
        autowidth = { enable = true, winwidth = 1.1 },
      }
    end,
  },
  {
    "sjava/readline.nvim",
    event = "User AstroFile",
  },
  {
    "vim-test/vim-test",
    event = "User AstroFile",
  },
  {
    "rmagatti/goto-preview",
    config = function() require("goto-preview").setup {} end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
  },
  {
    "vxpm/ferris.nvim",
    ft = "rust",
    opts = { create_commands = false },
  },
  {
    "echasnovski/mini.align",
    event = "User AstroFile",
    opts = {},
  },
  {
    "0xAdk/full_visual_line.nvim",
    keys = "V",
    opts = {},
  },
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    config = function()
      require("kulala").setup()
      vim.keymap.set(
        "n",
        "<C-k>",
        ":lua require('kulala').jump_prev()<CR>",
        { noremap = true, silent = true, buffer = 0 }
      )
      vim.keymap.set(
        "n",
        "<C-j>",
        ":lua require('kulala').jump_next()<CR>",
        { noremap = true, silent = true, buffer = 0 }
      )
      vim.keymap.set("n", "<C-l>", ":lua require('kulala').run()<CR>", { noremap = true, silent = true, buffer = 0 })
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    config = function()
      require("arrow").setup {
        show_icons = true,
        leader_key = "<leader>;", -- Recommended to be a single key
      }
      vim.keymap.set(
        "n",
        "<Leader>;",
        require("arrow.ui").openMenu,
        { noremap = true, silent = true, nowait = true, desc = "Open Arrow" }
      )
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    opts = { use_winbar = "smart", show_prompt = false },
  },
  {
    "briangwaltney/paren-hint.nvim",
    event = "User AstroFile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require "paren-hint" end,
  },
  {
    "nacro90/numb.nvim",
    lazy = false,
    config = function() require("numb").setup() end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    config = function() require("render-markdown").setup {} end,
  },
  {
    "TwIStOy/luasnip-snippets",
    dependencies = { "L3MON4D3/LuaSnip" },
    event = { "InsertEnter" },
    config = function()
      -- register all snippets into LuaSnip
      require("luasnip-snippets").setup()
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline[3] = status.component.file_info {
        filename = { modify = ":." },
        filetype = false,
      }

      local component = status.component.builder {
        {
          provider = function()
            local arrow_statusline = require "arrow.statusline"
            local arrow = arrow_statusline.text_for_statusline_with_icons()
            return status.utils.stylize(arrow, {
              padding = { left = 1 }, -- pad the right side
            })
          end,
        },
        hl = { fg = "#A6E3A1" },
      }
      table.insert(opts.statusline, 4, component)
    end,
  },
  {
    "andrewferrier/debugprint.nvim",
    event = "User AstroFile",
    dependencies = {
      "echasnovski/mini.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require("debugprint").setup() end,
    version = "*",
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    config = function() require("mkdnflow").setup {} end,
  },
  {
    "pechorin/any-jump.vim",
    event = "User AstroFile",
  },
  {
    "Mr-LLLLL/cool-chunk.nvim",
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require("cool-chunk").setup {} end,
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    "ryo33/nvim-cmp-rust",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local cmp = require "cmp"
      local compare = require "cmp.config.compare"
      cmp.setup.filetype({ "rust" }, {
        sorting = {
          priority_weight = 2,
          comparators = {
            -- deprioritize `.box`, `.mut`, etc.
            require("cmp-rust").deprioritize_postfix,
            -- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
            require("cmp-rust").deprioritize_borrow,
            -- deprioritize `Deref::deref` and `DerefMut::deref_mut`
            require("cmp-rust").deprioritize_deref,
            -- deprioritize `Into::into`, `Clone::clone`, etc.
            require("cmp-rust").deprioritize_common_traits,
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      on_open = function() vim.cmd "TWEnable" end,
      on_close = function() vim.cmd "TWDisable" end,
    },
  },
  {
    "ysmb-wtsg/in-and-out.nvim",
    config = function()
      vim.keymap.set("i", "<C-CR>", function() require("in-and-out").in_and_out() end)
      vim.keymap.set("n", "<C-CR>", function() require("in-and-out").in_and_out() end)
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>w"] = { desc = "windows" }
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    specs = {
      {
        "AstroNvim/astroui",
        ---@type AstroUIOpts
        opts = {
          icons = {
            GrugFar = "󰛔",
          },
        },
      },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = opts.mappings and opts.mappings or require("astrocore").empty_map_table()
          maps.n["<Leader>s"] = { desc = "Search" }
          maps.n["<Leader>sg"] = {
            function() require("grug-far").grug_far {} end,
            desc = "Run grup-far",
          }
          maps.x["<Leader>sg"] = {
            function() require("grug-far").with_visual_selection {} end,
            desc = "Run grup-far",
          }
        end,
      },
      {
        "zbirenbaum/copilot.lua",
        optional = true,
        opts = {
          filetypes = {
            ["grug-far"] = false,
            ["grug-far-history"] = false,
          },
        },
      },
    },
    ---@param opts GrugFarOptionsOverride
    -- NOTE: Wrapping opts into a function, because `astrocore` can set vim options
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        icons = {
          enabled = vim.g.icons_enabled,
        },
      } --[[@as GrugFarOptionsOverride]])
    end,
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    keys = {
      {
        "<leader>fs",
        function() require("rip-substitute").sub() end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
  {
    "dmtrKovalenko/caps-word.nvim",
    event = "User AstroFile",
    opts = {},
    keys = {
      {
        mode = { "i", "n" },
        "<C-s>",
        "<cmd>lua require('caps-word').toggle()<CR>",
      },
    },
  },
  -- {
  --   "elixir-tools/elixir-tools.nvim",
  --   ft = { "elixir" },
  --   init = function()
  --     local utils = require "astronvim.utils"
  --     astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "elixirls")
  --   end,
  --   version = "*",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local elixir = require "elixir"
  --     local elixirls = require "elixir.elixirls"
  --
  --     elixir.setup {
  --       nextls = { enable = true },
  --       credo = {},
  --       elixirls = {
  --         enable = true,
  --         cmd = "/home/zyb/.local/share/nvim/mason/bin/elixir-ls",
  --         settings = elixirls.settings {
  --           dialyzerEnabled = false,
  --           enableTestLenses = false,
  --         },
  --         on_attach = function(client, bufnr)
  --           vim.keymap.set("n", "<space>pf", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("n", "<space>fp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --         end,
  --       },
  --     }
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
}
