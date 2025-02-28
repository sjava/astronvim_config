return {
  "Saghen/blink.cmp",
  opts = {
    signature = { enabled = true },
  },
  specs = {
    "mikavilpas/blink-ripgrep.nvim",
    specs = {
      "Saghen/blink.cmp",
      opts = function(_, opts)
        table.insert(opts.sources.default, "ripgrep")
        return require("astrocore").extend_tbl(opts, {
          sources = {
            providers = {
              ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                -- the options below are optional, some default values are shown
                ---@module "blink-ripgrep"
                ---@type blink-ripgrep.Options
                opts = {
                  prefix_min_len = 3,
                  context_size = 5,
                  max_filesize = "1M",
                  project_root_marker = ".git",
                  search_casing = "--ignore-case",
                  additional_rg_options = {},
                  fallback_to_regex_highlighting = true,
                  debug = false,
                },
                transform_items = function(_, items)
                  for _, item in ipairs(items) do
                    item.labelDetails = {
                      description = "(rg)",
                    }
                  end
                  return items
                end,
              },
            },
          },
        })
      end,
    },
  },
}
