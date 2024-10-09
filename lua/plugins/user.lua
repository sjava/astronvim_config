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
  -- {
  --   "sjava/readline.nvim",
  --   event = "User AstroFile",
  --   config = function()
  --     local readline = require "readline"
  --     vim.keymap.set("!", "<M-f>", readline.forward_word)
  --     vim.keymap.set("!", "<M-b>", readline.backward_word)
  --     vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
  --     vim.keymap.set("!", "<C-e>", readline.end_of_line)
  --     vim.keymap.set("!", "<M-d>", readline.kill_word)
  --     vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
  --     vim.keymap.set("!", "<C-k>", readline.kill_line)
  --     vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
  --     vim.keymap.set("!", "<C-d>", "<Delete>") -- delete-char
  --     vim.keymap.set("!", "<C-h>", "<BS>") -- backward-delete-char
  --     vim.keymap.set("!", "<C-f>", "<Right>") -- forward-char
  --     vim.keymap.set("!", "<C-b>", "<Left>") -- backward-char
  --   end,
  -- },
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
      require("kulala").setup { default_view = "headers_body" }
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
      vim.keymap.set(
        "n",
        "<C-o>",
        ":lua require('kulala').copy()<CR>",
        { noremap = true, silent = true, buffer = 0, desc = "Copy the current request as a curl command" }
      )
      vim.keymap.set(
        "n",
        "<C-i>",
        ":lua require('kulala').from_curl()<CR>",
        { noremap = true, silent = true, buffer = 0, desc = "Paste curl from clipboard as http request" }
      )
      vim.keymap.set("n", "<CR>", ":lua require('kulala').run()<CR>", { noremap = true, silent = true, buffer = 0 })
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
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },
  -- {
  --   "TwIStOy/luasnip-snippets",
  --   dependencies = { "L3MON4D3/LuaSnip" },
  --   event = { "InsertEnter" },
  --   config = function()
  --     -- register all snippets into LuaSnip
  --     require("luasnip-snippets").setup()
  --   end,
  -- },
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
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
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
  -- {
  --   "ryo33/nvim-cmp-rust",
  --   dependencies = { "hrsh7th/nvim-cmp" },
  --   config = function()
  --     local cmp = require "cmp"
  --     local compare = require "cmp.config.compare"
  --     cmp.setup.filetype({ "rust" }, {
  --       sorting = {
  --         priority_weight = 2,
  --         comparators = {
  --           -- deprioritize `.box`, `.mut`, etc.
  --           require("cmp-rust").deprioritize_postfix,
  --           -- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
  --           require("cmp-rust").deprioritize_borrow,
  --           -- deprioritize `Deref::deref` and `DerefMut::deref_mut`
  --           require("cmp-rust").deprioritize_deref,
  --           -- deprioritize `Into::into`, `Clone::clone`, etc.
  --           require("cmp-rust").deprioritize_common_traits,
  --           compare.offset,
  --           compare.exact,
  --           compare.score,
  --           compare.recently_used,
  --           compare.locality,
  --           compare.sort_text,
  --           compare.length,
  --           compare.order,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "ysmb-wtsg/in-and-out.nvim",
    keys = {
      {
        "<C-CR>",
        function() require("in-and-out").in_and_out() end,
        mode = { "i", "n" },
      },
    },
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
  {
    "3rd/image.nvim",
    enabled = function() return not vim.g.neovide end,
    config = function() require("image").setup {} end,
  },
  {
    "3rd/diagram.nvim",
    enabled = function() return not vim.g.neovide end,
    ft = { "markdown" },
    dependencies = {
      "3rd/image.nvim",
    },
    opts = { -- you can just pass {}, defaults below
      renderer_options = {
        mermaid = {
          background = nil, -- nil | "transparent" | "white" | "#hex"
          theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
        },
      },
    },
  },
  {
    "letieu/jot.lua",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("jot").setup { notes_dir = "~/jot" }
      vim.keymap.set("n", "<leader>fj", function() require("jot").open() end, { desc = "Open jot" })
    end,
  },
  {
    "felpafel/inlay-hint.nvim",
    event = "LspAttach",
    config = true,
  },
  {
    "midoBB/nvim-quicktype",
    cmd = "QuickType",
    ft = { "typescript", "python", "java", "go", "rust", "cs", "swift", "elixir", "kotlin", "typescriptreact" },
  },
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    -- version = "v0.*",
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      highlight = { use_nvim_cmp_as_default = true },
      nerd_font_variant = "mono",
      trigger = {
        signature_help = { enabled = true },
      },
      keymap = {
        accept = "<C-y>",
      },
    },
    specs = {
      -- disable built in completion plugins
      { "hrsh7th/nvim-cmp", enabled = false },
      { "rcarriga/cmp-dap", enabled = false },
      { "L3MON4D3/LuaSnip", enabled = false },
      { "onsails/lspkind.nvim", enabled = false },
    },
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup {
        lsp = {
          enabled = true,
          name = "crates.nvim",
          ---@diagnostic disable-next-line: unused-local
          on_attach = function(_client, bufnr)
            local crates = require "crates"
            vim.keymap.set(
              "n",
              "<leader>lx",
              crates.expand_plain_crate_to_inline_table,
              { buffer = bufnr, desc = "Expand Plain Crate" }
            )
            vim.keymap.set(
              "n",
              "<leader>lX",
              crates.extract_crate_into_table,
              { buffer = bufnr, desc = "Extract Crate" }
            )
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
          end,
          actions = true,
          completion = true,
          hover = true,
        },
        completion = {
          crates = {
            enabled = true,
          },
        },
      }
    end,
  },
}
