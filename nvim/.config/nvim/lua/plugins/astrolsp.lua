-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    config = {
      gopls = {
        settings = {
          gopls = {
            directoryFilters = { "-reference-code" },
          },
        },
      },
      vue_ls = {
        cmd = function(dispatchers, config)
          return vim.lsp.rpc.start({
            "vue-language-server",
            "--stdio",
            "--tsdk=" .. config.root_dir .. "/node_modules/typescript/lib",
          }, dispatchers)
        end,
      },
    },
  },
}
