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
      term_colors = true,
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
        noice = true,
        gitsigns = true,
        lsp_trouble = true,
        ts_rainbow2 = true,
        treesitter = true,
        window_picker = true,
        overseer = true,
        grug_far = false,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    },
  },
  { import = "astrocommunity.pack.rust" },

  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.elixir-phoenix" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["cmp.entry.get_documentation"] = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
  },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.nvim-tree-pairs" },
  { import = "astrocommunity.motion.mini-ai" },
  {
    "echasnovski/mini.ai",
    opts = { custom_textobjects = { t = false }, n_lines = 500 },
  },

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
  { import = "astrocommunity.editing-support.text-case-nvim" },

  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.recipes.vscode-icons" },

  { import = "astrocommunity.icon.mini-icons" },

  { import = "astrocommunity.color.nvim-highlight-colors" },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = { enable_tailwind = true },
  },

  { import = "astrocommunity.neovim-lua-development.lazydev-nvim" },
  { import = "astrocommunity.neovim-lua-development.helpview-nvim" },

  { import = "astrocommunity.completion.copilot-lua" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-l>",
          accept_word = "<C-w>",
          accept_line = "<C-j>",
        },
      },
    },
  },

  -- { import = "astrocommunity.completion.supermaven-nvim" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
}
