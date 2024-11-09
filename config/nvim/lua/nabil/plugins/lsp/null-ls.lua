return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  config = function()
    local present, null_ls = pcall(require, "null-ls")

    if not present then
      return
    end

    local b = null_ls.builtins

    local sources = {
      b.formatting.gofumpt,
      b.formatting.goimports,
      b.diagnostics.golangci_lint,
    }

    null_ls.setup({
      debug = true,
      sources = sources,
    })
  end,
}
