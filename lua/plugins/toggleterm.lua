return {
  "akinsho/toggleterm.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      insert_mappings = false,
      terminal_mappings = false,
      start_in_insert = false,
      auto_scroll = false,
    })
  end,
}
