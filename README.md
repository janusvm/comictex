# comictex

This repository defines the `comicscript` LaTeX document class, which provides macros for formatting a comic script inspired by the style suggested by writer [Fred Van Lente](http://www.fredvanlente.com/comix.html).


## How to use
Place `comicscript.cls` in the same folder as your tex file, and put

```latex
\documentclass[<list of class options>]{comicscript}
```

in the beginning of the file.
See [examples/comicscript.tex](examples/comicscript.tex) for an example of how to use the class.


## Options

In addition to the options accepted by the `article` class (except for `twoside` and `twocolumn`, which are ignored), the following extra options are defined in `comicscript.cls`:

**Option** | **Effect**
--- | ---
`paged` (default) | enables the `\page` command and numbers panel references as `<PAGE#>.<PANEL#>`
`unpaged` | disables the `\page` command and numbers panel references simply as `<PANEL#>`


## Commands

The following commands are defined or redefined by the class:

**Command** | **Effect**
--- | ---
`\series{series name}{issue number}` | Saves the `series name` and `issue number` to variables used in the title and header
`\title{issue title}` | Saves the `issue title` to a variable; at least one of `\series` and `\title` must be set
`\author{author name}` | Saves the `author name` to a variable; unlike in `article`s, not setting this throws an error
`\maketitle` | For printing out the title, author, etc. on the first page
`\page` | Starts a new, automatically numbered comic page
`\panel[shot description]` | Starts a new, automatically numbered panel, with an optional shot description (wide, close-up, etc.)
`\begin{lettering} ... \end{lettering}` | Environment for inputting lettering items
`\dialogue{character}[descriptor]{text}` | Lettering item used for spoken dialogue
`\narration[descriptor]{text}` | Lettering item used for narration
`\sfx{text}` | Lettering item used for sound effects
