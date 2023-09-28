local M = {}

-- 所有自定义的按键绑定全部在这里设置
local key_maps = {
    basic_maps = {
        emacs_like = {
            forward = {
                enable = true,
                mode = "i",
                lhs = [[<C-f>]],
                rhs = [[<right>]]
            },
            backward = {
                enable = true,
                mode = "i",
                lhs = [[C-b]],
                rhs = [[<right]]
            },
            go_to_end = {
                enable = true,
                mode = "i",
                lhs ="<C-e>",
                rhs = "<esc>$a"
            },
            go_to_begin = {
                enable = true,
                mode = "i",
                lhs ="<C-a>",
                rhs = "<esc>^i"
            },
            delete_to_end = {
                enable = true,
                mode = "i",
                lhs ="<C-k>",
                rhs = "<esc>d$a"
            }
        }
    },
    plugin_maps = {
        file_tree = {
            toggle = {
                enable = true,
                mode = "n",
                lhs = [[<leader>e]],
                opts = {
                    desc = "toggle file explore"
                }
            },
        },
        complete = {
            select_next_item = {
                enalbe = true,
                mode = 'i',
                lhs = [[<C-n>]],
            },
            select_prev_item = {
                enable = true,
                mode = 'i',
                lhs = "<C-p>"
            },
            scroll_doc_down = {
                enable = true,
                mode = 'i',
                lhs = "<C-b>"
            },
            scroll_doc_up = {
                enable = true,
                mode = 'i',
                lhs = "<C-f>"
            },
            cancel_complete = {
                enable = true,
                mode = 'i',
                lhs = "<C-e>"
            },
            confirm_item = {
                enable = true,
                mode = 'i',
                lhs = "<cr>"
            },
            complete = {
                enable = true,
                mode = 'i',
                lhs = "<C-j>"
            },
            replace_complete = {
                enable = true,
                mode = 'i',
                lhs = "<S-CR>"
            }
        },
        finder = {
            find_project_file = {
                enable = true,
                mode = 'n',
                lhs = '<leader>f.',
                opts = {
                    desc = "find project file"
                }
            },
            find_buffer = {
                enable = true,
                mode = 'n',
                lhs = '<leader>fb',
                opts = {
                    desc = "find buffer"
                }
            },
            find_current_buffer = {
                enable = true,
                mode = 'n',
                lhs = '<leader>fc',
                opts = {
                    desc = "fzf find current buffer "
                }
            },
            find_command = {
                enable = true,
                mode = 'n',
                lhs = '<leader>f:',
                opts = {
                    desc = "find command"
                }
            },
            find_tag = {
                enable = true,
                mode = 'n',
                lhs = '<leader>ft',
                opts = {
                    desc = "find tag"
                }
            },
            find_root_file = {
                enable = true,
                mode = 'n',
                lhs = '<leader>f/',
                opts = {
                    desc = "from root find file"
                }
            },
            find_project_grep = {
                enable = true,
                mode = 'n',
                lhs = '<leader>fg',
                opts = {
                    desc = "grep find in project"
                }
            },
            find_old_files = {
                enable = true,
                mode   = 'n',
                lhs    = "<leader>fo",
                opts   = {
                    desc = "find old files"
                }
            },
            find_mark = {
                enable = true,
                mode = 'n',
                lhs = '<leader>fm',
                opts = {
                    desc = "find marks"
                }
            },
            find_regiesters = {
                enable = true,
                mode = 'n',
                lhs = '<leader>fr',
                opts = {
                    desc = "find register content"
                }
            },
            find_resume = {
                enable = true,
                mode = 'n',
                lhs = '<leader>fR',
                opts = {
                    desc = "find resume"
                }
            }
        },
        code = {
            comment = {
                enable = true,
                mode = 'n',
                lhs = 'gc',
                opts = {
                    desc = "comment / uncomment"
                }
            },
            comment_line = {
                enable = true,
                mode = 'n',
                lhs = 'gcc',
                opts = {
                    desc = "comment line"
                }
            },
            comment_text_object = {
                enable = true,
                mode = 'n',
                lhs = 'gc',
                opts = {
                    desc = 'text object  comment operate'
                }
            }
        },
        lsp = {
            go_to_declaration = {
                enable = true,
                mode = 'n',
                lhs = 'gD',
                opts = {
                    desc = 'go to Declaration'
                }
            },
            go_to_definition = {
                enable = true,
                mode = 'n',
                lhs = 'gd',
                opts = {
                    desc = 'go to go to definition'
                }
            },
            go_to_implemention = {
                enable = true,
                mode = 'n',
                lhs = 'gi',
                opts = {
                    desc = 'go to implementmmention'
                }
            },
            show_documention = {
                enable = true,
                mode = 'n',
                lhs = 'gs',
                opts = {
                    desc = 'show documention'
                }
            },
            action = {
                enable = true,
                mode = 'n',
                lhs = '<leader>ca',
                opts = {
                    desc = 'show action '
                }
            },
            go_to_type_definition = {
                enable = true,
                mode = 'n',
                lhs = 'gt',
                opts = {
                    desc = 'go to type definition'
                }
            },
            next_diagnostic = {
                enable = true,
                mode = 'n',
                lhs = ']d',
                opts = {
                    desc = 'next diagnostic'
                }
            },
            prev_diagnostic = {
                enable = true,
                mode = 'n',
                lhs = '[d',
                opts = {
                    desc = 'prev diagnostice'
                }
            },
            next_error = {
                enable = true,
                mode = 'n',
                lhs = ']e',
                opts = {
                    desc = 'next error'
                }
            },
            prev_error = {
                enable = true,
                mode = 'n',
                lhs = '[e',
                opts = {
                    desc = 'prev error'
                }
            },
            next_warning = {
                enable = true,
                mode = 'n',
                lhs = ']w',
                opts = {
                    desc = "next warning"
                }
            },
            prev_warning = {
                enable = true,
                mode = 'n',
                lhs = '[w',
                opts = {
                    desc = 'prev warning'
                }
            },
            format = {
                enable = true,
                mode = 'n',
                lhs = 'gf',
                opts = {
                    desc = "fort document"
                }
            }
        }
        ,edit = {
            add_surrond = {
                enable = true,
                mode = 'n',
                lhs = "sa",
                opts = {
                    desc = "add surrond"
                }
            },
            delete_surrond = {
                enalbe = true,
                mode = 'n',
                opts = {
                    desc = "delete surrond"
                }
            },
            replace_surrond = {
                enable = true,
                mode = 'n',
                opts = {
                    desc = "replace surrond"
                }
            }
        }
    }
}

M.key_maps = key_maps

local function generate_with_desc_opts(opts, prefix, group, func)
    local final_desc = prefix .. " Group: " .. group .. " Func: " .. func
    if (opts) then
        opts.desc = final_desc .. " Desc:" .. opts.desc
    else
        opts = {
            desc = final_desc
        }
    end
    return opts
end

-- 初始化基本的绑定,无需lazy load
function M.init_basic_maps()
    local basic_maps = key_maps.basic_maps
    for group, m in pairs(basic_maps) do
        for func, define in pairs(m) do
            if (define.enable) then
                opts = generate_with_desc_opts(define.opts, [[<Basic Map>]], group, func)
                vim.keymap.set(define.mode, define.lhs, define.rhs, opts)
            end
        end
    end
end

--生成 lazy vim 需要的keys形式
function M.get_lazy_keys(group, func, rhs)
    local define = M.key_maps.plugin_maps[group][func]
    local opts = generate_with_desc_opts(define.opts, [[<Plugin Map>]], group, func)
    return vim.tbl_extend('force', { define.lhs, rhs, mode = define.mode }, opts)
end

return M
