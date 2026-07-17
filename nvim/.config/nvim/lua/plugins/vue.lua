---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local vue_language_server_path = vim.fn.stdpath "data"
      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
    local typescript_sdk_path = vim.fn.stdpath "data"
      .. "/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"

    local function project_paths(root_dir)
      if not root_dir then return typescript_sdk_path, vue_language_server_path, "vue-language-server" end

      local project_typescript_sdk = vim.fs.joinpath(root_dir, "node_modules/typescript/lib")
      local project_vue_language_server = vim.fs.joinpath(root_dir, "node_modules/@vue/language-server")
      local project_vue_ls = vim.fs.joinpath(root_dir, "node_modules/.bin/vue-language-server")

      return vim.fn.isdirectory(project_typescript_sdk) == 1 and project_typescript_sdk or typescript_sdk_path,
        vim.fn.isdirectory(project_vue_language_server) == 1 and project_vue_language_server or vue_language_server_path,
        vim.fn.executable(project_vue_ls) == 1 and project_vue_ls or "vue-language-server"
    end

    local function vue_plugin(location)
      return {
        name = "@vue/typescript-plugin",
        location = location,
        languages = { "vue" },
        configNamespace = "typescript",
      }
    end

    opts.servers = astrocore.list_insert_unique(opts.servers, { "vtsls", "vue_ls" })
    opts.config.volar = nil
    opts.config.vue_ls = {
      cmd = function(dispatchers, config)
        local tsdk, _, cmd = project_paths(config.root_dir)
        return vim.lsp.rpc.start({ cmd, "--stdio", "--tsdk=" .. tsdk }, dispatchers)
      end,
      settings = {
        css = { lint = { unknownAtRules = "ignore" } },
        scss = { lint = { unknownAtRules = "ignore" } },
      },
    }
    opts.config.vtsls.before_init = function(_, config)
      local _, vue_ls_path = project_paths(config.root_dir)
      config.settings.vtsls.tsserver.globalPlugins = { vue_plugin(vue_ls_path) }
    end
    opts.config.vtsls.filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
    }
    opts.config.vtsls.settings.vtsls.tsserver.globalPlugins = { vue_plugin(vue_language_server_path) }
  end,
}
