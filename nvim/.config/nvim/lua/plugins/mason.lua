---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "basedpyright",
        "bash-language-server",
        "clangd",
        "codelldb",
        "css-lsp",
        "debugpy",
        "delve",
        "docker-language-server",
        "emmet-ls",
        "goimports",
        "gomodifytags",
        "gopls",
        "gotests",
        "html-lsp",
        "iferr",
        "impl",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "oxfmt",
        "oxlint",
        "prettier",
        "ruff",
        "selene",
        "stylua",
        "tailwindcss-language-server",
        "taplo",
        "vtsls",
        "vue-language-server",
      })
    end,
  },
}
