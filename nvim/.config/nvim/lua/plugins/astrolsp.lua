-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    servers = { "oxfmt" },
    formatting = {
      filter = function(client)
        local oxfmt_filetypes = {
          javascript = true,
          javascriptreact = true,
          typescript = true,
          typescriptreact = true,
          vue = true,
        }

        return not oxfmt_filetypes[vim.bo.filetype] or client.name == "oxfmt"
      end,
    },
    config = {
      oxfmt = {
        cmd = function(dispatchers, config)
          local cmd = vim.fs.joinpath(config.root_dir, "node_modules/vite-plus/bin/oxfmt")
          if vim.fn.executable(cmd) ~= 1 then cmd = "oxfmt" end

          return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
        end,
      },
      gopls = {
        settings = {
          gopls = {
            directoryFilters = { "-reference-code" },
          },
        },
      },
    },
  },
}
