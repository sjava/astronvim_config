local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

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
    "gregorias/coerce.nvim",
    event = "User AstroFile",
    config = function()
      require("coerce").setup {}
      require("coerce").register_case {
        keymap = "l",
        case = function(str) return vim.fn.tolower(str) end,
        description = "lowercase",
      }
    end,
  },
  {
    "0xAdk/full_visual_line.nvim",
    keys = "V",
    opts = {},
  },
  {
    -- "sjava/hurl.nvim",
    "jellydn/hurl.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "hurl",
    config = function()
      require("hurl").setup {
        -- Show debugging info
        debug = false,
        -- Show notification on run
        show_notification = false,
        -- Show response in popup or split
        mode = "popup",
        -- Default formatter
        formatters = {
          json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
          html = {
            "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
            "--parser",
            "html",
          },
        },
        env_file = {
          "hurl.env",
        },
      }
      vim.keymap.del("n", "<Leader>h")
      local wk = require "which-key"
      wk.register({
        h = { name = "Hurl Action" },
      }, { prefix = "<Leader>", buffer = 0 })
      vim.keymap.set(
        "n",
        "<Leader>ha",
        "<cmd>HurlRunnerAt<cr>",
        { noremap = true, silent = true, desc = "Run Request At", buffer = 0 }
      )
      vim.keymap.set(
        { "n", "v" },
        "<Leader>hA",
        "<cmd>HurlRunner<cr>",
        { noremap = true, silent = true, desc = "Run All Request", buffer = 0 }
      )
      vim.keymap.set(
        "n",
        "<Leader>he",
        "<cmd>HurlRunnerToEntry<cr>",
        { noremap = true, silent = true, desc = "Run Api request to entry", buffer = 0 }
      )
      vim.keymap.set(
        "n",
        "<Leader>ht",
        "<cmd>HurlToggleMode<cr>",
        { noremap = true, silent = true, desc = "Hurl Toggle Mode", buffer = 0 }
      )
      vim.keymap.set(
        "n",
        "<Leader>hv",
        "<cmd>HurlVerbose<cr>",
        { noremap = true, silent = true, desc = "Run Api in verbose mode", buffer = 0 }
      )
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    config = function()
      require("arrow").setup {
        show_icons = true,
        leader_key = "<leader>a", -- Recommended to be a single key
      }
      vim.keymap.set(
        "n",
        "<Leader>a",
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
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
    opts = {
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      separator = " ", -- Separator to use in chat
      prompts = prompts,
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
      mappings = {
        -- Use tab for completion
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        -- Close the chat
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        -- Reset the chat buffer
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        -- Accept the diff
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = "gmy",
        },
        -- Show the diff
        show_diff = {
          normal = "gmd",
        },
        -- Show the prompt
        show_system_prompt = {
          normal = "gmp",
        },
        -- Show the user selection
        show_user_selection = {
          normal = "gms",
        },
      },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"
      local select = require "CopilotChat.select"
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      -- Override the git prompts message
      opts.prompts.Commit = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = select.gitdiff,
      }
      opts.prompts.CommitStaged = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = function(source) return select.gitdiff(source, true) end,
      }

      chat.setup(opts)

      vim.api.nvim_create_user_command(
        "CopilotChatVisual",
        function(args) chat.ask(args.args, { selection = select.visual }) end,
        { nargs = "*", range = true }
      )

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command(
        "CopilotChatInline",
        function(args)
          chat.ask(args.args, {
            selection = select.visual,
            window = {
              layout = "float",
              relative = "cursor",
              width = 1,
              height = 0.4,
              row = 1,
            },
          })
        end,
        { nargs = "*", range = true }
      )

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command(
        "CopilotChatBuffer",
        function(args) chat.ask(args.args, { selection = select.buffer }) end,
        { nargs = "*", range = true }
      )

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then vim.bo.filetype = "markdown" end
        end,
      })

      -- Add which-key mappings
      local wk = require "which-key"
      wk.register {
        g = {
          m = {
            name = "+Copilot Chat",
            d = "Show diff",
            p = "System prompt",
            s = "Show selection",
            y = "Yank diff",
          },
        },
      }
    end,
    keys = {
      -- Show help actions with telescope
      {
        "<C-c>h",
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "<C-c>p",
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<C-c>p",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<C-c>e", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<C-c>t", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<C-c>r", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<C-c>R", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<C-c>n", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
      {
        "<C-c>v",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<C-c>x",
        ":CopilotChatInline<cr>",
        mode = "x",
        desc = "CopilotChat - Inline chat",
      },
      -- Custom input for CopilotChat
      {
        "<C-c>i",
        function()
          local input = vim.fn.input "Ask Copilot: "
          if input ~= "" then vim.cmd("CopilotChat " .. input) end
        end,
        desc = "CopilotChat - Ask input",
      },
      -- Generate commit message based on the git diff
      {
        "<C-c>m",
        "<cmd>CopilotChatCommit<cr>",
        desc = "Generate commit message for all changes",
      },
      {
        "<C-c>M",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "Generate commit message for staged changes",
      },
      -- Quick chat with Copilot
      {
        "<C-c>q",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then vim.cmd("CopilotChatBuffer " .. input) end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Debug
      { "<C-c>d", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with diagnostic
      { "<C-c>f", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      -- Clear buffer and chat history
      { "<C-c>l", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<C-c>v", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle Vsplit" },
    },
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
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown" },
    config = true,
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
    "joshuadanpeterson/typewriter",
    config = function()
      require("typewriter").setup {
        enable_with_zen_mode = true,
        enable_with_true_zen = true,
      }
    end,
    opts = {},
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
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>s"] = { desc = "Search" }
          maps.n["<Leader>sg"] = { "<Cmd>GrugFar<CR>", desc = "Run grup-far" }
        end,
      },
    },
    config = function() require("grug-far").setup {} end,
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
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local astro = require "astrocore"
          maps.n["<Leader>t"] = vim.tbl_get(opts, "_map_sections", "t")

          local serpl = {
            callback = function() astro.toggle_term_cmd "serpl" end,
            desc = "ToggleTerm serpl",
          }
          maps.n["<Leader>sr"] = { serpl.callback, desc = serpl.desc }

          maps.n["<Leader>tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
          maps.n["<Leader>th"] =
            { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
          maps.n["<Leader>tv"] =
            { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
          maps.n["<F7>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
          maps.t["<F7>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
          maps.i["<F7>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
          maps.n["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
          maps.t["<C-'>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
          maps.i["<C-'>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
        end,
      },
    },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
      ---@param t Terminal
      on_create = function(t)
        vim.opt_local.foldcolumn = "0"
        vim.opt_local.signcolumn = "no"
        if t.hidden then
          local toggle = function() t:toggle() end
          vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
          vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        end
      end,
      shading_factor = 2,
      direction = "float",
      float_opts = { border = "rounded" },
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
