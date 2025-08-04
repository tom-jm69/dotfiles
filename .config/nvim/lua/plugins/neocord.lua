return {
  {
    'IogaMaster/neocord',
    config = function()
      require('neocord').setup({
        -- General options
        logo                = "auto",                     -- "auto" or url
        logo_tooltip        = nil,                        -- nil or string
        main_image          = "language",                 -- "language" or "logo"
        client_id           = "1157438221865717891",      -- Use your own Discord application client id (not recommended)
        log_level           = nil,                        -- Log messages at or above this level
        debounce_timeout    = 10,                         -- Number of seconds to debounce events
        blacklist           = {},                         -- List of patterns to disable RP based on the current file
        file_assets         = {},                         -- Custom file asset definitions
        show_time           = true,                       -- Show the timer
        global_timer        = false,                      -- Timer won't update when events are triggered
        buttons             = nil,                        -- List of buttons or a function returning such list

        -- Rich Presence text options
        editing_text        = "Editing %s",               -- Editable file format
        file_explorer_text  = "Browsing %s",              -- File explorer format
        git_commit_text     = "Committing changes",       -- Git commit format
        plugin_manager_text = "Managing plugins",         -- Plugin manager format
        reading_text        = "Reading %s",               -- Read-only file format
        workspace_text      = "Working on %s",            -- Git repository format
        line_number_text    = "Line %s out of %s",        -- Line number format
        terminal_text       = "Using Terminal",           -- Terminal mode format
      })
    end,
    event = "VeryLazy", -- Optional: Lazy load the plugin
  }
}
