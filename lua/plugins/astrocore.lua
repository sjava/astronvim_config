-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        python3_host_prog = "python",
        -- ["test#strategy"] = "wezterm",
        ["test#strategy"] = "shtuff",
        shtuff_receiver = "devrunner",
        ["test#rust#runner"] = "cargotest",
        -- ["test#rust#cargotest#test_options"] = "-- --nocapture",
        ["test#rust#cargotest#test_options"] = {
          nearest = { "--", "--nocapture" },
        },
        any_jump_disable_default_keybindings = 1,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        ["<Leader>ue"] = {
          function() require("copilot.suggestion").toggle_auto_trigger() end,
          desc = "toggle copilot suggestion",
        },
        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

        ["<Leader>j"] = { desc = "vim-test" },
        ["<Leader>jn"] = { "<cmd>TestNearest<cr>", desc = "test near" },
        ["<Leader>jf"] = { "<cmd>TestFile<cr>", desc = "test file" },
        ["<Leader>ja"] = { "<cmd>TestSuite<cr>", desc = "test all" },
        ["<Leader>jl"] = { "<cmd>TestLast<cr>", desc = "test last" },
        ["<Leader>jv"] = { "<cmd>TestVisit<cr>", desc = "test visit" },

        ["<Leader>A"] = { desc = "AnyJump" },
        ["<Leader>Aj"] = { "<cmd>AnyJump<cr>", desc = "Jump to definition under cursor" },
        ["<Leader>Ab"] = { "<cmd>AnyJumpBack<cr>", desc = "open previous opened file (after jump)" },
        ["<Leader>Al"] = { "<cmd>AnyJumpLastResults<cr>", desc = "open last closed anyjump window" },

        ["<Leader>ws"] = { "<C-w>s", desc = "horizontal split window" },
        ["<Leader>wv"] = { "<C-w>v", desc = "vertical split window" },
        ["<Leader>wh"] = { "<C-w>h", desc = "left window" },
        ["<Leader>wj"] = { "<C-w>j", desc = "below window" },
        ["<Leader>wl"] = { "<C-w>l", desc = "right window" },
        ["<Leader>wk"] = { "<C-w>k", desc = "up window" },
        ["<Leader>ww"] = {
          function()
            local picker = require "window-picker"
            local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(picked_window_id)
          end,
          desc = "Pick a window",
        },
        ["<Leader>wz"] = {
          function() require("zen-mode").toggle() end,
          desc = "toggle zen mode",
        },
        ["<C-w>z"] = { "<cmd>WindowsMaximize<cr>", desc = "maximize windows" },

        ["gp"] = { desc = "Goto Preview" },
        ["gpd"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "definition" },
        ["gpt"] = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "type definition" },
        ["gpi"] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "implementation" },
        ["gpr"] = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "references" },

        ["<C-c>"] = { desc = "copilot chat" },
      },
      v = {
        ["<Leader>jj"] = { "<cmd>AnyJumpVisual<cr>", desc = "jump to selected text" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<esc>"] = { "<C-\\><C-n>", desc = "escape terminal" },
      },
    },
  },
}
