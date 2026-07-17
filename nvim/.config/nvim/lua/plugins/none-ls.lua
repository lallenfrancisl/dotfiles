-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(
      opts.sources,
      require("null-ls").builtins.formatting.prettier.with {
        filetypes = { "svg" },
        extra_args = { "--parser", "html" },
      }
    )
  end,
}
