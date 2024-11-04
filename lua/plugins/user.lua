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
    "vim-test/vim-test",
    event = "User AstroFile",
  },
  {
    "rmagatti/goto-preview",
    config = function() require("goto-preview").setup {} end,
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
    "Saghen/blink.cmp",
    event = "InsertEnter",
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      highlight = { use_nvim_cmp_as_default = true },
      nerd_font_variant = "mono",
      trigger = {
        signature_help = { enabled = true },
      },
      keymap = { preset = "enter" },
      windows = {
        autocomplete = {
          border = "rounded",
        },
        documentation = {
          auto_show = true,
          border = "rounded",
        },
        signature_help = {
          border = "rounded",
        },
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
        completion = {
          cmp = {
            enabled = false,
          },
        },
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        lsp = {
          enabled = true,
          actions = false,
          completion = true,
          hover = true,
        },
      }
    end,
  },
  {
    "cdmill/focus.nvim",
    cmd = { "Focus", "Zen", "Narrow" },
    opts = {},
  },
}
