-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 5000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
      "kulala_ls",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      -- basedpyright = {
      --   settings = {
      --     basedpyright = {
      --       -- disableLanguageServices = false,
      --       analysis = {
      --         autoImportCompletions = true,
      --         autoSearchPaths = true,
      --         diagnosticMode = "openFilesOnly",
      --         useLibraryCodeForTypes = true,
      --       },
      --     },
      --   },
      -- },
      ["kulala_ls"] = {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      },
      ["rust-analyzer"] = {
        capabilities = {
          workspace = {
            didChangeConfiguration = {
              dynamicRegistration = true,
            },
          },
        },
      },
      ["cssls"] = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      },
      ["html"] = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      if client.name == "rust-analyzer" then
        vim.keymap.set(
          "n",
          "<Leader>lc",
          function() vim.cmd.RustLsp "openCargo" end,
          { buffer = true, desc = "Open Cargo.toml" }
        )
        vim.keymap.set(
          "n",
          "<Leader>le",
          function() vim.cmd.RustLsp "expandMacro" end,
          { silent = true, buffer = bufnr, desc = "Expand macro" }
        )
        vim.keymap.set(
          "n",
          "<Leader>lE",
          function() vim.cmd.RustLsp "explainError" end,
          { silent = true, buffer = bufnr, desc = "Explain Error" }
        )
        vim.keymap.set(
          "n",
          "<Leader>lo",
          function() vim.cmd.RustLsp "externalDocs" end,
          { buffer = true, desc = "Open Documentation" }
        )
        vim.keymap.set(
          "n",
          "<Leader>lp",
          function() vim.cmd.RustLsp "parentModule" end,
          { silent = true, buffer = bufnr, desc = "Parent Module" }
        )
        vim.keymap.set(
          "n",
          "<Leader>lP",
          function() vim.cmd.RustLsp "rebuildProcMacros" end,
          { silent = true, buffer = bufnr, desc = "Rebuild ProcMacros" }
        )
        vim.keymap.set(
          "n",
          "<Leader>lt",
          function() vim.cmd.RustLsp "testables" end,
          { silent = true, buffer = bufnr, desc = "select testables" }
        )
        vim.keymap.set(
          "n",
          "<Leader>lR",
          function() vim.cmd.RustLsp "runnables" end,
          { silent = true, buffer = bufnr, desc = "select runnables" }
        )

        require("ferris").create_commands(bufnr)
        vim.keymap.set(
          "n",
          "<Leader>lm",
          "<cmd>FerrisViewMemoryLayout<cr>",
          { buffer = true, desc = "View Memory Layout" }
        )
        return
      end
      if client.name == "lua_ls" then
        local lua_config = require("astrocore").extend_tbl(client.config.settings.Lua, {
          diagnostics = {
            globals = { "vim" },
          },
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        })

        client.config.settings.Lua = lua_config
        return
      end
    end,
  },
}
