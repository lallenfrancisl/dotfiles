-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type AstroLSPOpts
local opts = {
  servers = { "oxfmt" },
  formatting = {
    filter = function(client)
      local preferred_formatters = {
        javascript = "oxfmt",
        javascriptreact = "oxfmt",
        typescript = "oxfmt",
        typescriptreact = "oxfmt",
        vue = "oxfmt",
        html = "oxfmt",
      }

      local formatter = preferred_formatters[vim.bo.filetype]
      return not formatter or client.name == formatter
    end,
  },
  config = {
    cssls = {
      settings = {
        css = { lint = { unknownAtRules = "ignore" } },
        scss = { lint = { unknownAtRules = "ignore" } },
      },
    },
    oxfmt = {
      cmd = function(dispatchers, config)
        local cmd = vim.fs.joinpath(config.root_dir, "node_modules/vite-plus/bin/oxfmt")
        if vim.fn.executable(cmd) ~= 1 then cmd = "oxfmt" end

        return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
      end,
    },
    gopls = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = { dynamicRegistration = true },
        },
      },
      settings = {
        gopls = {
          directoryFilters = { "-reference-code" },
        },
      },
    },
    html = {
      filetypes = { "html", "templ", "svg" },
    },
    vtsls = {
      settings = {
        javascript = { preferences = { importModuleSpecifier = "non-relative" } },
        typescript = { preferences = { importModuleSpecifier = "non-relative" } },
      },
    },
  },
}

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = opts,
}
