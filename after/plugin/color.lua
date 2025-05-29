function ChangeTheme(color)
    vim.cmd.colorscheme(color)
end

function ThemeOptionsChange()
    local options = {
        "github_dark",
        "github_dark_default",
        "github_dark_colorblind",
        "github_dark_high_contrast",
        "github_dark_tritanopia",
        "github_light",
        "github_light_default",
        "github_light_high_contrast",
    }

    for i, option in ipairs(options) do
        print(i .. ". " .. option)
    end

    local choice_str = vim.fn.input("Enter your choice: ")
    local choice = tonumber(choice_str)

    if choice and choice >= 1 and choice <= #options then
        vim.cmd.colorscheme(options[choice])
    else
        print("Invalid choice. Please enter a number between 1 and " .. #options)
    end
end

ChangeTheme("github_dark_default")
