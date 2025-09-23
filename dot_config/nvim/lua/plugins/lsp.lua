return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable('lus_ls')
            vim.lsp.enable('clangd')
        end
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
}
