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
        noice = true,
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
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    opts = function()
      local adapter
      local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
      local cfg = require "rustaceanvim.config"
      if success then
        local package_path = package:get_install_path()
        local codelldb_path = package_path .. "/codelldb"
        local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
        local this_os = vim.loop.os_uname().sysname

        -- The path in windows is different
        if this_os:find "Windows" then
          codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
          liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
        else
          -- The liblldb extension is .so for linux and .dylib for macOS
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      else
        adapter = cfg.get_codelldb_adapter()
      end

      local cmd = { "rust-analyzer" }
      success, package = pcall(function() return require("mason-registry").get_package "rust-analyzer" end)
      if success then
        local package_path = package:get_install_path()
        cmd = { package_path .. "/../../bin/rust-analyzer" }
      end

      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      local server = astrolsp_avail and astrolsp.lsp_opts "rust_analyzer"
      server = require("astrocore").extend_tbl(server, { cmd = cmd })
      return { server = server, dap = { adapter = adapter } }
    end,
    config = function(_, opts) vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim) end,
  },
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
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
            auto_open = {
              enabled = false,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
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

  { import = "astrocommunity.project.nvim-spectre" },
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

  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.test.neotest" },
  -- { import = "astrocommunity.completion.fittencode-nvim" },
}
