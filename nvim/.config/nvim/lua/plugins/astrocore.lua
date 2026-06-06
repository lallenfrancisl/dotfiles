---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    opts.diagnostics = opts.diagnostics or {}
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}

    local sign_text = vim.tbl_get(opts.diagnostics, "signs", "text") or {}

    opts.diagnostics.virtual_text = {
      prefix = function(diagnostic) return " " .. (sign_text[diagnostic.severity] or "■") end,
      format = function(diagnostic) return " " .. diagnostic.message .. " " end,
    }
    opts.diagnostics.signs = false

    opts.mappings.n["<Leader>Sl"] = {
      function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
      desc = "Load root session",
    }
  end,
}
