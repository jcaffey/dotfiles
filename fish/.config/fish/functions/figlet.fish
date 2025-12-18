function fgl
    if test (count $argv) -eq 0
        return
    end

    set -l font_dir /usr/local/Cellar/figlet/*/share/figlet/fonts
    set -l fonts_dir (echo $font_dir)

    pushd $fonts_dir >/dev/null

    set -l font (
        ls *.flf |
        sort |
        fzf --no-multi --reverse \
            --preview "figlet -f {} -w \$FZF_PREVIEW_COLUMNS $argv" \
            --preview-window up
    )

    if test -n "$font"
        figlet -f "$font" $argv | pbcopy
    end

    popd >/dev/null
end
