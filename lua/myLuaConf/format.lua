local opts = {
  lsp_fallback = true,
  async = false,
  timeout_ms = 1000,
}

require("lze").load({
  {
    "conform.nvim",
    for_cat = "format",
    -- cmd = { "" },
    event = { "BufReadPre", "BufNewFile" },
    -- ft = "",
    keys = {
      { "<leader>FF", desc = "[F]ormat [F]ile" },
    },
    -- colorscheme = "",
    after = function(plugin)
      local conform = require("conform")

      conform.setup({
        formatters = {
          yamlfmt = {
            args = { "-formatter", "retain_line_breaks_single=true" },
          },
        },
        formatters_by_ft = {
          -- NOTE: download some formatters in lspsAndRuntimeDeps
          -- and configure them here
          lua = { "stylua" },
          -- go = { "gofmt", "golint" },
          -- templ = { "templ" },
          -- Conform will run multiple formatters sequentially
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          -- Use a sub-list to run only the first available formatter
          css = { "prettierd" },
          json = { "prettierd" },
          markdown = { "prettierd" },
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          yaml = { "yamlfmt" },
          -- go = { "gofmt", "goimports" },
          nix = { "nixfmt" },
          sql = { "sqlfluff" },
        },
        format_on_save = opts,
      })

      vim.keymap.set({ "n", "v" }, "<leader>FF", function()
        conform.format(opts)
      end, { desc = "[F]ormat [F]ile" })
    end,
  },
})
