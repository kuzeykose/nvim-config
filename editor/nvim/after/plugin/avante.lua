local ok, avante = pcall(require, "avante")
if not ok then return end

avante.setup({
    provider = "claude",
    claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-6",
        timeout = 30000,
        temperature = 0,
        max_tokens = 8096,
    },
    mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        focus = "<leader>af",
        toggle = {
            default = "<leader>at",
            debug = "<leader>ad",
        },
        diff = {
            ours = "co",
            theirs = "ct",
            all_theirs = "ca",
            both = "cb",
            cursor = "cc",
            next = "]x",
            prev = "[x",
        },
        submit = {
            normal = "<CR>",
            insert = "<C-s>",
        },
    },
    hints = { enabled = true },
    windows = {
        position = "right",
        wrap = true,
        width = 40,
        sidebar_header = {
            enabled = true,
            align = "center",
        },
    },
    highlights = {
        diff = {
            current = "DiffText",
            incoming = "DiffAdd",
        },
    },
    diff = {
        autojump = true,
        list_opener = "copen",
    },
})
