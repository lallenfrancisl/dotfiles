return {
  "rebelot/kanagawa.nvim",
  opts = {
    compile = false,
    dimInactive = false,
    overrides = function(colors)
      local theme = colors.theme
      local makeDiagnosticColor = function(color)
        local c = require "kanagawa.lib.color"
        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
      end

      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
        DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
        DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
        DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
      }
    end,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
  },
}
