require("lze").load({
  {
    "nvim-lint",
    for_cat = "lint",
    -- cmd = { "" },
    event = "FileType",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function(plugin)
      local lint = require("lint")

      lint.linters_by_ft = {
        -- NOTE: download some linters in lspsAndRuntimeDeps
        -- and configure them here
        -- markdown = {'vale',},
        docker = { "hadolint" },
        -- go = { "golangcilint" },
        html = { "htmlhint" },
        lua = { "luacheck" },
        nix = { "statix" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        python = { "ruff" },
        sql = { "sqlfluff" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
      vim.keymap.set("n", "<leader>L", function()
        lint.try_lint()
      end, { desc = "[L]int current file" })
    end,
  },
})
