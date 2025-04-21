-- Customize None-ls sources
local null_ls = require "null-ls"

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, config)
    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- require "none-ls.diagnostics.eslint_d",
      -- require "none-ls.code_actions.eslint_d",
      null_ls.builtins.formatting.prettier.with {
        extra_filetypes = { "svg" },
      },
    }
    return config -- return final config table
  end,
}
