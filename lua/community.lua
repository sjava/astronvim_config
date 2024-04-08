-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      dim_inactive = { enabled = true },
      integrations = {
        aerial = true,
        cmp = true,
        mason = true,
        notify = true,
        neotree = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
        mini = {
          enabled = true,
          indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        },
        noice = false,
        gitsigns = true,
        lsp_trouble = true,
        ts_rainbow2 = true,
        treesitter = true,
        window_picker = true,
        overseer = true,
      },
    },
  },
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },

  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.elixir-phoenix" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popup = {
          position = { row = 15 },
        },
        popupmenu = {
          position = { row = 18 },
        },
      },
    },
  },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.mini-ai" },
  {
    "echasnovski/mini.ai",
    opts = { custom_textobjects = { t = false }, n_lines = 500 },
  },

  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.syntax.vim-easy-align" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        options = { number = true, relativenumber = true },
      },
    },
  },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },

  { import = "astrocommunity.code-runner.compiler-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },

  { import = "astrocommunity.test.neotest" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "mrcjkb/rustaceanvim",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function(_, opts)
      local index = 0
      for i, v in ipairs(opts["adapters"]) do
        if v.name == "neotest-rust" then
          index = i
          break
        end
      end
      if index > 0 then table.remove(opts["adapters"], index) end
      table.insert(opts["adapters"], require "rustaceanvim.neotest")
      return opts
    end,
  },

  { import = "astrocommunity.lsp.garbage-day-nvim" },
}
