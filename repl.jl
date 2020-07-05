import REPL
import REPL.LineEdit
import REPL.Terminals
import REPL.LineEdit: terminal, Prompt

using TerminalUserInterfaces
using FIGlet
const TUI = TerminalUserInterfaces
using Crayons
using Highlights
using Highlights.Lexers
using Highlights.Format

function LineEdit.refresh_line(s)
   rewrite_with_prompt(s)
   LineEdit.refresh_multi_line(s)
end

const REPL_LOCATION = 42

@nospecialize # use only declared type signatures

function rewrite_with_prompt(s)
    io = IOBuffer()
    outbuf = IOContext(io, stdout)
    termbuf = Terminals.TerminalBuffer(outbuf)
    LineEdit.write(termbuf, "\e[$(REPL_LOCATION + 1);1H")
    LineEdit.write(termbuf, "\e[2K")
    LineEdit.write(termbuf, "│")
    LineEdit.write(termbuf, "\e[$(REPL_LOCATION);1H")
    write(terminal(s), take!(io))
    flush(terminal(s))
end

function LineEdit.write_prompt(terminal, p::Prompt)
    prefix = LineEdit.prompt_string(p.prompt_prefix)
    suffix = LineEdit.prompt_string(p.prompt_suffix)
    LineEdit.write(terminal, "\e[$(REPL_LOCATION + 1);1H")
    LineEdit.write(terminal, "\e[2K")
    LineEdit.write(terminal, "│")
    LineEdit.write(terminal, "\e[$(REPL_LOCATION + 2);1H")
    LineEdit.write(terminal, "\e[2K")
    LineEdit.write(terminal, "│")
    LineEdit.write(terminal, "\e[$(REPL_LOCATION);1H")
    LineEdit.write(terminal, prefix)
    LineEdit.write(terminal, Base.text_colors[:bold])
    width = LineEdit.write_prompt(terminal, p.prompt)
    LineEdit.write(terminal, Base.text_colors[:normal])
    LineEdit.write(terminal, suffix)
    return width
end

function clear()
    for line in REPL_LOCATION:REPL_LOCATION+2
        TUI.move_cursor(line, 1)
        TUI.clear_line()
        print('│')
    end
    TUI.move_cursor(REPL_LOCATION, 1)
end

function Format.render(io::IO, ::MIME"text/ansi", tokens::Format.TokenIterator)
    for (str, id, style) in tokens
        fg = style.fg.active ? map(Int, (style.fg.r, style.fg.g, style.fg.b)) : :nothing
        bg = style.bg.active ? map(Int, (style.bg.r, style.bg.g, style.bg.b)) : :nothing
        crayon = Crayon(
            foreground = fg,
            background = bg,
            bold       = style.bold,
            italics    = style.italic,
            underline  = style.underline,
        )
        print(io, crayon, str, inv(crayon))
    end
end

function run_code()
    words = [
        "hello",
        "world",
    ]
    colors = [
        "\e[31m", # Crayon(foreground = :red)
        "\e[34m", # Crayon(foreground = :blue)
    ]
    w, h = TUI.terminal_size()
    TUI.move_cursor(h ÷ 3 + 2, w ÷ 2 - length(join(words, " ")) ÷ 2)
    for (i, word) in enumerate(words)
        print(colors[i]); sleep(1)
        for c in word
            print(c); sleep(0.25)
        end
        if i < length(words)
            print(' '); sleep(0.25)
        end
    end
end

function show_code()
    code = raw"""
    words = [
        "hello",
        "world",
    ]
    colors = [
        "\e[31m", # Crayon(foreground = :red)
        "\e[34m", # Crayon(foreground = :blue)
    ]
    w, h = TUI.terminal_size()
    TUI.move_cursor(h ÷ 3, w ÷ 2 - length(join(words, " ")) ÷ 2)
    for (i, word) in enumerate(words)
        print(colors[i]); sleep(1)
        for c in word
            print(c); sleep(0.25)
        end
        if i < length(words)
            print(' '); sleep(0.25)
        end
    end
    """
    w, h = TUI.terminal_size()
    iob = IOBuffer()
    highlight(iob, MIME("text/ansi"), code, JuliaLexer)
    content = String(take!(iob))
    split_content = split(content, "\n")
    for (i, line) in enumerate(split_content)
        TUI.move_cursor(h ÷ 3 + 3 + i, w ÷ 2 - maximum(length.(split(code, "\n"))) ÷ 2)
        println(stdout, line)
    end
end

function colorful_canvas()
    w, h = TUI.terminal_size()

    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(h, w - 10), :limit=>true)
    FIGlet.render(ioc, "Canvas", "DOS Rebel")
    text = String(take!(iob))
    maximum_width = maximum(length.(split(text, "\n")))
    maximum_height = length(split(text, "\n"))
    row = h ÷ 3 - ( maximum_height )
    col = w ÷ 2 - ( maximum_width ÷ 2 )

    TUI.hide_cursor()
    r = row
    for line in split(text, "\n")
        TUI.move_cursor(r, col)
        r += 1
        print(Crayon(foreground = :yellow), line)
    end

    ioc = IOContext(iob, :displaysize=>(h, w - 10), :limit=>true)
    FIGlet.render(ioc, "Canva", "DOS Rebel")
    text = String(take!(iob))
    r = row
    for line in split(text, "\n")
        TUI.move_cursor(r, col)
        r += 1
        print(Crayon(foreground = :red), line)
    end

    ioc = IOContext(iob, :displaysize=>(h, w - 10), :limit=>true)
    FIGlet.render(ioc, "Canv", "DOS Rebel")
    text = String(take!(iob))
    r = row
    for line in split(text, "\n")
        TUI.move_cursor(r, col)
        r += 1
        print(Crayon(foreground = :blue), line)
    end

    ioc = IOContext(iob, :displaysize=>(h, w - 10), :limit=>true)
    FIGlet.render(ioc, "Can", "DOS Rebel")
    text = String(take!(iob))
    r = row
    for line in split(text, "\n")
        TUI.move_cursor(r, col)
        r += 1
        print(Crayon(foreground = :green), line)
    end

    ioc = IOContext(iob, :displaysize=>(h, w - 10), :limit=>true)
    FIGlet.render(ioc, "Ca", "DOS Rebel")
    text = String(take!(iob))
    r = row
    for line in split(text, "\n")
        TUI.move_cursor(r, col)
        r += 1
        print(Crayon(foreground = :magenta), line)
    end

    ioc = IOContext(iob, :displaysize=>(h, w - 10), :limit=>true)
    FIGlet.render(ioc, "C", "DOS Rebel")
    text = String(take!(iob))
    r = row
    for line in split(text, "\n")
        TUI.move_cursor(r, col)
        r += 1
        print(Crayon(foreground = :cyan), line)
    end

    TUI.show_cursor()
end

atreplinit() do repl
    @async begin
        p = repl.interface.modes[1]
        p.prompt = "    julia> "
    end
end
