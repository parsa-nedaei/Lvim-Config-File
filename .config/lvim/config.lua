-- Attention: You can Clone the whole code, or just copy the necessary parts

-- -- -- -- -- -- -- -- -- -- --
-- Activation of lvim.plugins
lvim.plugins = { 
  { -- Ondarker casts a little bit contrast to the main theme.
    "navarasu/onedark.nvim",
     priority = 1000, -- make sure to load this before all the other start plugins
     config = function() require('onedark').setup {
      style = 'darker'
    }
    require('onedark').load()
    end
  },
  { -- julia-vim is necessary if you are looking for using LaTex within lvim
    "JuliaEditorSupport/julia-vim",
  },
}

-- -- -- -- -- -- -- -- -- -- --
-- Set up real-time diagnostics (Pretty useful when combined by hover diagnostics - line 40)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with( -- Make sure that necessary LSPs are installed through :Mason
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = true,
  }
)

-- -- -- -- -- -- -- -- -- -- --
-- linting (Ensure that necessary linters are installed via :Mason)
lvim.lint_on_save = true

-- -- -- -- -- -- -- -- -- -- --
-- format on save (Ensure you have installed necessary formatters through :Mason like prettier or ...)
lvim.format_on_save = true -- whenever :w is used, based on installed formatter, this triggers code formatting
-- NOTE: sometimes it becomes annoying

-- -- -- -- -- -- -- -- -- -- --
-- This will wipe out the problem of unreadable diagnostics geting out of the window.
-- hover diagnostics 
vim.diagnostic.config({
  virtual_text = false -- It is better to disable virtual text.
})
-- show line diagnostics
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
