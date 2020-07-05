using TerminalUserInterfaces
using FIGlet
const TUI = TerminalUserInterfaces
using Markdown
using TerminalExtensions
using Crayons
using UnicodePlots
using SparseArrays

Base.@kwdef struct SlideTitle
end

function TUI.draw(s::SlideTitle, area::TUI.Rect, buf::TUI.Buffer)
    # Get FIGlet string
    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(TUI.height(area), TUI.width(area)), :limit=>true)
    FIGlet.render(ioc, "Terminal User Interfaces in Julia", "ANSI Regular")
    title = String(take!(iob))

    # Draw FIGlet string
    maximum_width = maximum(length.(split(title, "\n")))
    maximum_height = length(split(title, "\n"))
    row = TUI.height(area) ÷ 2 - ( maximum_height )
    col = TUI.width(area) ÷ 2 - ( maximum_width ÷ 2 )
    TUI.set(buf, col, row, split(title, "\n"))
    byline = "Dheepak Krishnamurthy"
    TUI.set(buf, TUI.width(area) ÷ 2 - length(byline) ÷ 2, row + length(split(title, "\n")) + 1, byline, Crayon(bold = true))

    link = "https://github.com/kdheepak/juliacon2020-terminal-user-interfaces-in-julia"
    TUI.set(buf, TUI.width(area) ÷ 2 - length(link) ÷ 2, row + length(split(title, "\n")) + 5, link, TUI.Crayon(foreground = :blue, underline = true))

    # Draw border
    TUI.draw(TUI.Block(), area, buf)
end

struct SlideMarkdownBlock
    block::TUI.MarkdownBlock
end

function TUI.draw(s::SlideMarkdownBlock, area::TUI.Rect, buf::TUI.Buffer)
    s.block.text.content[1].text[1] = ""
    TUI.draw(s.block, area, buf)

    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(TUI.height(area), TUI.width(area) - 10), :limit=>true)
    FIGlet.render(ioc, "How Terminals Work", "ANSI Regular")
    title = String(take!(iob))

    # Draw FIGlet string
    maximum_width = maximum(length.(split(title, "\n")))
    maximum_height = length(split(title, "\n"))
    row = TUI.height(area) ÷ 4 - ( maximum_height )
    col = TUI.width(area) ÷ 2 - ( maximum_width ÷ 2 )
    TUI.set(buf, col, row, split(title, "\n"))

end

struct SlideTypeWriter
    tick::Ref{Int}
    rate::Ref{Int}
end

function TUI.draw(s::SlideTypeWriter, area::TUI.Rect, buf::TUI.Buffer)
    rate = s.rate[]
    frames = 30
    TUI.draw(TUI.Block(), area, buf)

    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(TUI.height(area), TUI.width(area) - 10), :limit=>true)
    FIGlet.render(ioc, "Typewriter", "DOS Rebel")
    title = String(take!(iob))

    # Draw FIGlet string
    maximum_width = maximum(length.(split(title, "\n")))
    maximum_height = length(split(title, "\n"))
    row = TUI.height(area) ÷ 3 - ( maximum_height )
    col = TUI.width(area) ÷ 2 - ( maximum_width ÷ 2 )
    TUI.set(buf, col, row, split(title, "\n"))


        str = raw"""

                  .__________________.
|                 |                  |
\    _____________|                  |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""

    if (s.tick[] ÷ rate % frames) == 1

        str = raw"""

                  .__________________.
|                 |                  |
\    _____________|                  |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 2

        str = raw"""

                 .__________________.
|                |                  |
\    ____________|                  |___
 o==/____________|   h              |___XX
    \____________|    |             |___XX
  /              |____|_____________|      \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 3

        str = raw"""

                .__________________.
|               |                  |
\    ___________|                  |____
 o==/___________|   he             |____XX
    \___________|     |            |____XX
  /             |_____|____________|       \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""

    elseif (s.tick[] ÷ rate % frames) == 4

        str = raw"""

               .__________________.
|              |                  |
\    __________|                  |_____
 o==/__________|   hel            |_____XX
    \__________|      |           |_____XX
  /            |______|___________|        \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 5

        str = raw"""

              .__________________.
|             |                  |
\    _________|                  |______
 o==/_________|   hell           |______XX
    \_________|       |          |______XX
  /           |_______|__________|         \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 6

        str = raw"""

             .__________________.
|            |                  |
\    ________|                  |_______
 o==/________|   hello          |_______XX
    \________|        |         |_______XX
  /          |________|_________|          \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""

    elseif (s.tick[] ÷ rate % frames) == 7

        str = raw"""

            .__________________.
|           |                  |
\    _______|                  |________
 o==/_______|   hello          |________XX
    \_______|         |        |________XX
  /         |_________|________|           \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""

    elseif (s.tick[] ÷ rate % frames) == 8

        str = raw"""

           .__________________.
|          |                  |
\    ______|                  |_________
 o==/______|   hello w        |_________XX
    \______|          |       |_________XX
  /        |__________|_______|            \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 9

        str = raw"""

          .__________________.
|         |                  |
\    _____|                  |__________
 o==/_____|   hello wo       |__________XX
    \_____|           |      |__________XX
  /       |___________|______|             \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 10

        str = raw"""

         .__________________.
|        |                  |
\    ____|                  |___________
 o==/____|   hello wor      |___________XX
    \____|            |     |___________XX
  /      |____________|_____|              \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 11

        str = raw"""

        .__________________.
|       |                  |
\    ___|                  |____________
 o==/___|   hello worl     |____________XX
    \___|             |    |____________XX
  /     |_____________|____|               \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 12

        str = raw"""

       .__________________.
|      |                  |
\    __|                  |_____________
 o==/__|   hello world    |_____________XX
    \__|              |   |_____________XX
  /    |______________|___|                \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 13

        str = raw"""

      .__________________.
|     |                  |
\    _|                  |______________
 o==/_|   hello world.   |______________XX
    \_|               |  |______________XX
  /   |_______________|__|                 \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 14

        str = raw"""

      .__________________.
|     |                  |
\    _|                  |______________
 o==/_|   hello world.   |______________XX
    \_|               |  |______________XX
  /   |_______________|__|                 \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/

"""
    elseif (s.tick[] ÷ rate % frames) == 15

        str = raw"""

      .__________________.
|     |                  |
\    _|                  |______________
 o==/_|   hello world.   |______________XX
    \_|               |  |______________XX
  /   |_______________|__|                 \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CR
"""
    elseif (s.tick[] ÷ rate % frames) == 16

        str = raw"""

      .__________________.
      |                  |
\    _|                  |______________
 o==/_|   hello world.   |______________XX
    \_|               |  |______________XX
  /   |_______________|__|                 \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CR
"""
    elseif (s.tick[] ÷ rate % frames) == 17

        str = raw"""

                  .__________________.
                  |                  |
     _____________|                  |__
 o==/_____________|   hello world.   |__XX
/   \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CR
"""

    elseif (s.tick[] ÷ rate % frames) == 18

        str = raw"""

                  .__________________.
                  |                  |
     _____________|                  |__
 o==/_____________|   hello world.   |__XX
/   \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CR
"""

    elseif (s.tick[] ÷ rate % frames) == 19

        str = raw"""
                  .__________________.
                  |                  |
                  |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 20

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 21

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 22

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 23

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 24

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 25

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 26

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 27

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 28

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    elseif (s.tick[] ÷ rate % frames) == 29

        str = raw"""
                  .__________________.
                  |                  |
|                 |                  |
\    _____________|   hello world.   |__
 o==/_____________|                  |__XX
    \_____________|   |              |__XX
  /               |___|______________|     \
 [''''''''''''''''''''''''''''''''''''''''''']
 | (1) (2) (3) (4) (5) (6) (7) (8) (9) (0)   |
 |  (Q) (W) (E) (R) (T) (Y) (U) (I) (O) (P)  |
 | (A) (S) (D) (F) (G) (H) (J) (K) (L) (;)   |
 |   (Z) (X) (C) (V) (B) (N) (M) (<) (>) (.) |
 \___________________________________________/
                    CRLF
"""
    end

    arr = split(str , "\n")

    col = TUI.left(area) + TUI.width(area) ÷ 2 - maximum(length.(arr)) ÷ 2
    row = TUI.top(area) + TUI.height(area) ÷ 2 - length(arr) ÷ 2
    TUI.set(buf, col, row, arr)

end
struct SlideCanvas
end

function TUI.draw(s::SlideCanvas, area::TUI.Rect, buf::TUI.Buffer)
    TUI.draw(TUI.Block(), area, buf)

    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(TUI.height(area), TUI.width(area) - 10), :limit=>true)
    FIGlet.render(ioc, "Canvas", "DOS Rebel")
    title = String(take!(iob))

    # Draw FIGlet string
    maximum_width = maximum(length.(split(title, "\n")))
    maximum_height = length(split(title, "\n"))
    row = TUI.height(area) ÷ 3 - ( maximum_height )
    col = TUI.width(area) ÷ 2 - ( maximum_width ÷ 2 )
    TUI.set(buf, col, row, split(title, "\n"))

end

struct SlideStateMachine
end

function TUI.draw(s::SlideStateMachine, area::TUI.Rect, buf::TUI.Buffer)
    TUI.draw(TUI.Block(), area, buf)

    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(TUI.height(area), TUI.width(area) - 10), :limit=>true)
    FIGlet.render(ioc, "State Machine", "DOS Rebel")
    title = String(take!(iob))

    # Draw FIGlet string
    maximum_width = maximum(length.(split(title, "\n")))
    maximum_height = length(split(title, "\n"))
    row = TUI.height(area) ÷ 3 - ( maximum_height )
    col = TUI.width(area) ÷ 2 - ( maximum_width ÷ 2 )
    TUI.set(buf, col, row, split(title, "\n"))

    link = "https://www.linusakesson.net/programming/tty/"
    TUI.set(buf, TUI.width(area) ÷ 2 - length(link) ÷ 2, TUI.height(area) - TUI.height(area) ÷ 4 - 2, link, TUI.Crayon(foreground = :blue, underline = true))
end

struct SlideInteractiveApp
    list_option_index::Ref{Int}
    list_options::Vector{TUI.Word}
    tick::Ref{Int}
end

function TUI.draw(s::SlideInteractiveApp, area::TUI.Rect, buf::TUI.Buffer)
    TUI.draw(TUI.Block(), area, buf)

    iob = IOBuffer()
    ioc = IOContext(iob, :displaysize=>(TUI.height(area), TUI.width(area) - 10), :limit=>true)
    FIGlet.render(ioc, "Terminal User Interfaces", "ANSI Regular")
    title = String(take!(iob))

    # Draw FIGlet string
    maximum_width = maximum(length.(split(title, "\n")))
    maximum_height = length(split(title, "\n"))
    row = TUI.height(area) ÷ 8
    col = TUI.width(area) ÷ 2 - ( maximum_width ÷ 2 )
    TUI.set(buf, col, row, split(title, "\n"))

    sl = TUI.SelectableList(
        TUI.Block(), s.list_options, 1, s.list_option_index[]
    )
    a = TUI.Rect(TUI.width(area) ÷ 2 - TUI.width(area) ÷ 5 - TUI.width(area) ÷ 10, TUI.height(area) ÷ 2, TUI.width(area) ÷ 5, TUI.height(area) ÷ 4)
    a = TUI.Rect(a, TUI.Margin(0, 0))
    TUI.draw(sl, a, buf)

    link = "https://github.com/kdheepak/TerminalUserInterfaces.jl"
    TUI.set(buf, TUI.width(area) ÷ 2 - length(link) ÷ 2, TUI.height(area) - TUI.height(area) ÷ 8 , link, TUI.Crayon(foreground = :blue, underline = true))

end

function main(slide_number = 1)
    TUI.initialize()
    y, x = 1, 1

    count = 1
    t = TUI.Terminal()

    # TUI.enableRawMode()
    TUI.clear_screen()
    TUI.hide_cursor()

    stw = SlideTypeWriter(1, 30)
    sia = SlideInteractiveApp(
        1,
        [
            TUI.Word(text = w) for w in [
                "lineplot",
                "scatterplot",
                "stairs",
                "barplot",
                "histogram",
                "boxplot",
                "spy",
                "heatmap",
                "densityplot",
            ]
        ],
        1,
    )
    slides = [
        SlideTitle(),
        SlideMarkdownBlock(
            TUI.MarkdownBlock(
                block = TUI.Block(border = TUI.BorderNone),
                text = Markdown.parse("""
### HOW TERMINALS WORK

- A **Typewriter**
- A **Canvas**
- A **State Machine**
                """),
            ),
        ),
        stw,
        SlideCanvas(),
        SlideStateMachine(),
        sia,
    ]
    use_diff = false

    plts = [
        lineplot([-1, 2, 3, 7], [-1, 2, 9, 4], title = "Line Plot", name = "my line", xlabel = "x", ylabel = "y"),
        scatterplot(randn(50), randn(50), title = "Scatter Plot"),
        stairs([1, 2, 4, 7, 8], [1, 3, 4, 2, 7], color = :red, style = :post, title = "Staircase Plot"),
        barplot(["Paris", "New York", "Moskau", "Madrid"], [2.244, 8.406, 11.92, 3.165], title = "Bar Plot"),
        histogram(randn(1000) .* 0.1, nbins = 15, closed = :left, title = "Histogram Plot"),
        boxplot(["one", "two"], [[1,2,3,4,5], [2,3,4,5,6,7,8,9]], title="Grouped Boxplot", xlabel="x"),
        spy(sprandn(50, 120, .05), title = "Spy plot"),
        heatmap(collect(0:30) * collect(0:30)', xscale=0.1, yscale=0.1, xoffset=-1.5, colormap=:inferno, title = "Heatmap Plot"),
        densityplot(randn(1000), randn(1000), title = "Density Plot"),
    ]
    lineplot!(plts[1], [0, 4, 8], [10, 1, 10], color = :blue, name = "other line")
    densityplot!(plts[end], randn(1000) .+ 2, randn(1000) .+ 2)

    while true

        w, h = TUI.terminal_size()

        r = TUI.Rect(x, y, w, h)

        TUI.draw(t, slides[slide_number], r)

        if slide_number != 1
            TUI.set(TUI.current_buffer(t), 2, h, "Dheepak Krishnamurthy", Crayon(foreground = :blue))
            slide_number_string = "$slide_number / $(length(slides))"
            TUI.set(TUI.current_buffer(t), w - 2 - length(slide_number_string), h, slide_number_string, Crayon(foreground = :blue))
        end

        TUI.flush(t, use_diff)
        use_diff = true

        if slide_number == 5
            TUI.move_cursor(h ÷ 3, w ÷ 4)
            data = read(abspath("images/tty.png"))
            TerminalExtensions.iTerm2.display_file(
                                       data;
                                       io=stdout,
                                       width="$(round(Int, w/2))",
                                       filename="image",
                                       inline=true,
                                       preserveAspectRatio=true
                                      )
        end

        if slide_number != 5
            c = TUI.get_event(t)
        else
            c = take!(t.stdin_channel)
        end

        if c == 'q'
            break
        elseif c == 'j'
            slide_number += 1
            use_diff = false
            if slide_number > length(slides)
                slide_number = length(slides)
            end
        elseif c == 'k'
            slide_number -= 1
            use_diff = false
            if slide_number < 1
                slide_number = 1
            end
        elseif c == '\x03'
            # keyboard interrupt
            break
        else
            if slide_number == 3
                stw.tick[] += 1
                if c == '+'
                    stw.rate[] = 30
                elseif c == '-'
                    stw.rate[] = 5
                end
            elseif slide_number == 4
                if c == 'r'
                    t.ispaused[] = true
                    TUI.disable_raw_mode()
                    TUI.show_cursor()
                    TUI.move_cursor(42, 10)
                    run(`julia --project --banner=no --color=yes --startup-file=no -e 'include("repl.jl")' -i`)
                    TUI.hide_cursor()
                    TUI.enable_raw_mode()
                    t.ispaused[] = false
                end
            elseif slide_number == 6
                sia.tick[] += 1
                if c == 's' # Ctrl-j
                    sia.list_option_index[] += 1
                    use_diff = false
                    if sia.list_option_index[] > length(plts)
                        sia.list_option_index[] = length(plts)
                    end
                elseif c == 'w'
                    sia.list_option_index[] -= 1
                    use_diff = false
                    if sia.list_option_index[] < 1
                        sia.list_option_index[] = 1
                    end
                end
                iob = IOBuffer()
                ioc = IOContext(iob, :color => true)
                print(ioc, plts[sia.list_option_index[]])
                s = String(take!(iob))
                for (i, line) in enumerate(split(s, "\n"))
                    TUI.move_cursor(h ÷ 2 - 3 + i, w ÷ 2)
                    println(line)
                end
            end
        end

    end

    TUI.cleanup()
    t.ispaused[] = true

end

if length(ARGS) == 0
    main(1)
else
    main(parse(Int, ARGS[end]))
end
