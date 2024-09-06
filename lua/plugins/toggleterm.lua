return {
  "akinsho/toggleterm.nvim",
  opts = function(_, opts)
    opts.insert_mappings = false
    opts.terminal_mappings = false
    opts.start_in_insert = false
  end,
}
