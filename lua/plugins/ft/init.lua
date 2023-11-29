return {
    {
        -- https://github.com/dhruvasagar/vim-table-mode
        -- help table-mode
        "dhruvasagar/vim-table-mode",
        ft = "markdown",
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    }

}
