## THERE IS ONLY VIM

## Thoughts on general setup and getting around a document
  It seems that absolute line numbers and relative line numbers are both important. I have opted to default to relative and show absolute line numbers in insert mode. You can peek with `i` if you need an absolute number. I'm a vim newb, but my thought is that it is more intuitive and efficient to move around a document with `{` `}`, `(` `)`, `ctrl+u`, `ctrl+d` and the help of `/sometext`, `?sometext`, `H`, `M`, `L`, etc.. to quickly jump where you need to go. This is faster and more intuitive than `:line-number` as there are many other ways to get to that line and I can't type numbers quickly. It would take me the same amount of time to type `/longstring` as it would `:73`. Line numbers also become a problem when files are huge. More digits means less efficient. Finally, typing `:73` would require four keystrokes. Typing the maximum relative number will always be 2 digits unless you're a crazy person with a crazy big screen and pressing `j` or `k` for a direction leaves us with only three keystrokes. NEAT!

  That being said, I do think it is absolutely valid to work with absolute line numbers so I'm training myself to use `i` to peek at them when I need it.

  Add this to ~/.vimrc

  " Use hybrid numbers by default
  set nu rnu

  " Show absolute numbers in insert mode
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END

  " Call noh on esc+esc because just escape causes vim bugs
  " like starting in replace mode.
  nnoremap <esc><esc> :noh<CR>

  " Disable arrow keys to get used to hjkl movement
  nnoremap <Left> :echo "don't be stupid."<CR>
  vnoremap <Left> :<C-u>echo "don't be stupid."<CR>

  nnoremap <Right> :echo "don't be stupid."<CR>
  vnoremap <Right> :<C-u>echo "don't be stupid."<CR>

  nnoremap <Up> :echo "don't be stupid."<CR>
  vnoremap <Up> :<C-u>echo "don't be stupid."<CR>

  nnoremap <Down> :echo "don't be stupid."<CR>
  vnoremap <Down> :<C-u>echo "don't be stupid."<CR>

## Modes
  - `esc` Normal
  - `:` Command
  - `i` Insert
  - `R` Replace
  - `v` Visual
  - `ctrl+v` Visual Block
  - `V` Visual Line

## OMG HELP ME COMMANDS
  - `esc` to return to normal mode
  - `:q!` to quit without writing file and no prompt before quit
  - `u` undo
  - `ctrl+r` redo

## Commands
  - `d` delete (copy)
  - `c` change (delete then insert mode)
  - `y` yank (copy)
  - `v` visually select (visual mode)

## Text Objects
  - `w` words
  - `s` sentences
  - `p` paragraphs
  - `t` tags

## Motions
  - `a` all
  - `i` in
  - `t` 'til forward
  - `T` 'til backward
  - `f` find forward
  - `F` find backward

## Command Format
  {number of times}{command}{motion}{text object}

## Common commands
  - `ctrl+o`, `ctrl+i` move forward and backward through jump history (especially useful when editing multiple files) NOTE: when I first learned this I didn't realize this was how to jump between files as quickly as you would with tabs. Remember these!
  - `d15G` delete lines from cursor position to line 15
  - `5dk` delete five lines up
  - `r` replace character
  - `a` append text after letter the cursor is on
  - `diw` delete in word
  - `caw` change all word (same as diw but grabs whitespace and puts you in edit mode)
  - `dd` delete (cut) line into default register (i remember as `delete down` as `1dd` would be the same thing and `1dk` would mean delete 1 line above. k = up)
  - `cc` change line
  - `p` put default register text to right of cursor or `P` to put text left of cursor
  - `yy` yank (copy) line into default register
  - `3yy` yank 3 lines
  - `di)` delete in parentheses
  - `yi"` yank in double quotes
  - `da'` delete all *including* single quotes
  - `dt,` delete until comma
  - `bdw` beginning of word, delete word
  - `bcw` same as `bdw` but puts you in insert mode to replace text
  - `vi"` visually select all text in double quotes
  - `va"` visually select all text including double quotes
  - `ciw'ctrl+r"'` wrap text in double quotes (change in word, replace with ', insert the contents of the " register, add last ') or just use surround.vim

## Movement
  - Move cursor: `h` left, `j` down, `k` up, `l` right
    - Move cursor: `H`igh, `M`iddle, `L`ow in window (top, middle, bottom)
  - Use `/blah` where blah is something you want to navigate to
  - Move cursor between paragraphs: `{` and `}`
  - Move cursor between sentences: `(` and `)`
  - Jump to beginning of file `gg`
  - Jump to end of file (G)
  - Scroll window down `ctrl+e` (especially useful at the bottom of a file to move your work 'up')
  - Scroll window up `ctrl+y`
  - Scroll down (forward) one page `ctrl+f`
  - Scroll up (back) one page `ctrl+b`
  - Scroll down `ctrl+d` and confine window to document
  - Scroll up `ctrl+u` and confine window to document

## Lines
  - `I` insert at beginning of line
  - `A` insert at end of line
  - `O` Open new line above and switch to insert mode
  - `o` Open new line below and switch to insert mode
  - `D` Delete to end of line
  - `d0` Delete to beginning of line
  - `C` Change to end of line
  - `c0` Change to beginning of line (^ for soft beginning)
  - `shift+{left|right}-arrow` to jump between words (works in normal and insert modes)
  - `<` and `>` tab left and right respectively
  - Jump to end of line - `end` or regex syntax ($)
    -`g_` go to last non-blank character of line
  - Jump to beginning of line - `0` for hard beginning of line and regex syntax (^) for soft beginning of line
    - `g0` go to first non-blank character
  - `#G` move cursor to specified line number

## Words
  - `w` beginning of word
  - `e` end of word
  - `b` previous word

## Search
  - `/expression` search forward
  - `?expression` search backward
  - `n` next
  - `N` previous

## Search and replace (substitute)
  - `:s/search/replace` find "search" in the current line and change it to "replace." This will only change the first occurence of the word "search."
  - `:s/search/replace/g` find "search" in the current line and change it to "replace." Changes all occurences in the line.
  - `:3,10s/search/replace/g` find "search" in lines 3-10 (inclusive) and replace it with the word "replace".
  - `:%s/search/replace/gc` find "search" in the entire document and ask me to [c]onfirm replacing it with the word "replace" each time.
  - The first character after `:%s` is the delimiter and can be most non-alphanumeric characters (but not \, " or |). This means that `:%s/a/b` does the same thing as `:%s#a#b`
  - See `:help magic` if you want to be throughly confused.

## Execute shell command
  - `:!ls` any command prefixed with `!` will be executed by your shell.
  - `:e new/dir/path.txt` creates a buffer for path.txt and you can edit this buffer but you won't be able to save it because the path doesn't exist. No worries, run `:!mkdir -p %:h` to create the dir and use % (current buffer path and file name) followed by :h to *only* return the path. NOTE: get used to % because it comes in handy. Especially when you're editing .vimrc and need to source it. Just use `:source %`
  <https://til.hashrocket.com/posts/d2bed4a1e5-create-a-new-file-in-a-new-directory>

## Reading and writing selections to disk (partials)
  - Any text highlighted in visual modes can be written to a new file. Just highlight your text then `:w filename`. I think of this as partials in rails. This didn't seem incredibly useful at first, but it is. See example below.
  - Insert text from a file using `:r filename` the text will be inserted at the position of your cursor.
  
  Example: While writing aliases for .zshrc I wanted to move them into separate files by program. I simply wrote the list, highlighted what I wanted with `V{count}{j|k}` then `:w zsh/.aliases/program`. PROTIP THOUGH: this will put you in the new buffer window and your selection is gone. DANG! Don't worry. This is how we do it:

  1. From the new buffer window `:!mkdir -p %:h` to create our path
  2. `:w` to save the file
  3. `ctrl+o` to get back to our original file
  4. `gv` to reselect the highlighted text we wrote to disk
  5. `d` to delete

You try. If you've pulled this repo and want to learn vim I suggest you use `:r` to read in the aliases to create a list, then practice highighting to write them out. Extra protip: vim stores the last 10 files you've opened. You can jump to them using `'0` to `'9` if you're jump history with `ctrl+o` is long.

TODO: todo lists in vim using `0r !head -n1 README.md`

## Buffers are better than tabs. I promise.

UPDATE: this takes about 20 seconds before you realize you need the BufExplorer plugin. `:BufExplorer` then go nuts.

  Buffers are just files that vim has in memory. Any file you open will be listed in buffers unless you ask vim to get rid of it with `:bd{buffer-number}`. Here are the common buffer commands I use all the time.
  - `:ls` list buffers
  - `:b{buffer-number}` switch to that buffer. IMPORTANT: vim will ask if you want to save your changes to the file (if it has changed), press y or your changes are gone. You have been warned.
  - `:bd{buffer-number}` close buffer. NOTE: if you are editing a file and vim complains about the file being opened in another program (probably another instance of vim) this is the command you need to remove the buffer from vim.
  - `:vs#{buffer-number}` open buffer in vertical split
  - `:s#{buffer-number}` open buffer in horizontal split

## Windows and multiple buffers
  - `:vert h ctrlp-mappings` open help at ctrlp mappings in vertical split
  - TODO: bindings + tmux

## The magical %
  - `%` jump to matching parentheses, bracket, or curly brace.
  - `%` will jump to other *matching* items depending upon the programming language. See ruby example below.

  `%` jumps are marked with []
  [d]ef eql?[(]other[)]
    options = [{] verbose: true [}O=]

    [i]f other.is_a? String
      self.to_s == other || self.to_s[(]options[)] == other
    [e]lse
      self.to_s[(]options[)] == other.to_s[(]options[)]
    [e]nd
  [e]nd

  Given the method above, `:line-number-of-def` will place the cursor on the first line of the method declaration. `V` will highlight the line. `%` will highlight from the line to (and including) the end line. Now you can yank, change, or whatever you need to do. If you are indenting simply press `<` or `>` and then `.` to repeat indentation.

## Registers
- The default or unnamed register is `"` this gets updated with the latest deleted or yanked text.
- Registers 1-9 hold the text you have yanked/deleted, so you never really lose anything.
- Use `:reg` or `:registers` to see what the registers hold.
- In insert mode you can `ctrl+r "` to paste from default register
- In normal mode you can `"1p` which means grab register 1 and paste
- `ayiw` yank in word to the a register
- Copy text from register " (default) to + (system) `:let @+=@"`

- Update .vimrc with the following:
" Allow copy/paste between vims and system by setting the clipboard to be unnamed register.
set clipboard^=unnamed

##cheat sheet to snippet example
This is another real world example as I was creating this document. Let's look at how we can use some simple command and vim awesomeness to get what we want quickly. Again, it may look like a lot of commands, but this is all second nature stuff that happens very quickly with just a little practice. Don't be overhwlemed, just keep practicing.

Example text:
Excellent article covering registers in detail:
<https://www.brianstorti.com/vim-registers/>
[title](https://www.example.com)
TODO: exit with 0 when `:<>!snipi add name` and remove add!

Steps to awesomeness:
`r!cheat markdown | ag url`
`daw`
`wcwRegisters`
`k`
`ds>`
`D` so we don't get newline
`f(p` move to ( and paste url
`dt)` delete til ) to remove old url

Output:
Excellent article covering registers in detail:
[Registers](https://www.brianstorti.com/vim-registers)

## Working with chunks of text
  For the next three instructions, move your cursor to the line of the instruction text before making a selectio

  1. Select the text between ---- with `5j V 9j`
  2. Select the text between "hashes = [" and "]" with `7jvi]`
  3. Select only id numbers with `4j 0 f0 ctrl+v 7j`
`
  ----------------------------------------
  hashes = [
    { id: 0, name: "foo 0" },
    { id: 1, name: "foo 1" },
    { id: 2, name: "foo 2" },
    { id: 3, name: "foo 3" },
    { id: 4, name: "foo 4" },
    { id: 5, name: "foo 5" },
    { id: 6, name: "foo 6" },
    { id: 7, name: "foo 7" }
  ]
  ----------------------------------------
`
## Splitting lines
  Split a line with: `f ` (f then spacebar) to get to whitespace, `ciw` kill whitespace, `return`
  left side |  right side

## Plugins that make you unstoppable
  * EasyMotion - This is, by far, the coolest and fastest way to navigate a document. EasyMotion asks you what you are looking for and then puts anchor points in the window to jump to the location matching the characters you provided. If you need to move more than a few lines this is way faster than using relative line numbers to jump up or down. This is what makes my preferred strategy for word wrapping work. See word wrapping.

  [EasyMotion](https://github.com/easymotion/vim-easymotion)
  ![EasyMotion](https://camo.githubusercontent.com/d5f800b9602faaeccc2738c302776a8a11797a0e/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f333739373036322f323033393335392f61386539333864362d383939662d313165332d383738392d3630303235656138333635362e676966)

  - `<Leader>j` show anchors down. Same for k to go up.
  - `<Leader>f` show anchors [f]orward in the document. Use `F` to reverse.
  - `s` [s]earch forward and backward for 2 characters in the window.
  - See vimrc for all mappings

  * NerdTree - it is better than the default netrw plugin, so i use it, but i suggest configuring netrw as well so you can get comfortable with it when you SSH into a box that doesn't have plugins.

  - hjkl or arrows to navigate
  - `return` to open directory
  - `s` open in vertical split
  - `i` open in horizontal split
  - `t` open in new tab (`T` for silently)
  - `go` preview in new window but do not move cursor to window
  - `o` preview in new window and move cursor
  - `cd` change directory (useful so that starting ctrlp doesnt start indexing a bunch of files if you happen to open vim outside of a project directory)
  - `p` jump to parent
  - `I` show dotfiles
  - `A` toggle zoom
  - `?` for more details

Protip: use EasyMotion to quickly jump to a directory or file. If you're using my config: `<Leader>j{char}s` to open in a vertical split.

* Surround - This plugin is suprisingly useful and amazing. The documentation was a little difficult for me to understand because the examples use `'` and `"` to wrap text. Remember that these are at the end of the example commands, so this has nothing to do with buffers or marks. `'` and `"` are simply two common characters that surround text. :facepalm:

IMPORTANT: Surround distinguishes between `{` and `}` (and all other brackets except `<` because it's magical. See single line HTML example below.) An opening bracket means pad with whitespace. Closing bracket means no whitespace. Example: [ test ] vs [test]

  - `cs'"` change surrounding character {replace-char} - 'test' -> "test"
  - `ds'` delete surrounding {char} - 'test' -> test
  - `yss<` yank surround sentence (line) {char} - test -> <test>
  - `ysiw"` yank surround in word {char} - test -> "test"
  - `ysis"` yank surround in sentence {char} - test test test! -> "test test test!"
  - `$v0S"` surround entire line with double quotes (go to end, visual mode, go to beginning, substitue line, ") NOTE: this doesnt work when selecting from beginning to end for me.

  Write HTML and let surround add the closing tag: `VS<p>` (visual line mode, Substitute line, paragraph tag, surround makes closing p tag)
  <p>
    test
  </p>

  Single line html: write text, `yss<p` <p>test</p>

  Collapse a block of HTML: `JJds ` collapse twice, delete surrounding space. I have to hit spacebar twice because my spacebar is the leader key.
      <p>       -> <p>test</p>
        test
      </p>

  Surrounding things that aren't words or sentences. Surround C-\ with a single quote using `vt S'` (cursor on C, visually select til space, surround ')
  bind -n C-\    ->   bind -n 'C-\'


   Use repeat.vim to repeat the surround command (it works out of the box). `ysiw"` to surround test with ". then `b."` to jump to [b]eginning of previous word and repeat with . then enter character ".
  test test -> "test" "test"
  
  https://github.com/tpope/vim-surround/blob/master/doc/surround.txt

* Airline - Every vim user has this. It's pretty and it displays useful info. My .vimrc also has tmuxline installed which uses the theme from airline.

* CtrlP - Fuzzy find your files
`ctrl+p` as the name suggests will open a fuzzy search and list any files that match. By default it will start indexing files from where you started vim. You can use `:pwd` to find out where you are and `:cd path/to/something` if you want to change it.

  - `ctrl+f` and `ctrl+b` to switch modes modes [f]orward and [b]ackward through project files, buffers, and mru (most recently used) files.
  - `ctrl+d` to toggle file name only mode.
  - `ctrl+v` open file in [v]ertical split
  - `ctrl+t` open file in [t]ab
  - `ctrl+x` open file in horizontal split. It's not mnemonic, but it's convenient.
  - `ctrl+n` and `ctrl+p` to cycle search history

* FZF - Using ag + fzf === unstoppable - TODO

* Fugitive - git awesomeness from vim. Anything tpope makes is amazing.
  - `:G` better git status view
  - `:Gw` git add for the current buffer
  - `:Gblame` git blame on current buffer
  - `:Gcommit` git commit
  - `:Gpush` git push

* Gitgutter - more git awesomeness that compliments fugitive. See example below.

## Fugitive + Gitgutter example
I often find myself forgetting to create a git commit with a single unit of work. It's useful to be able to commit sections of a file all from vim. This is how: 

  - install vim-gitgutter and vim-fugitive.
  - add lines to file (your gutter should have a green plus for lines added)
  - stage a "hunk" with git gutter with visual mode: `V<Leader>hs` in english thats: `V`isual line mode, `h`unk `s`tage
  - `:GStatus` to ask fugitive with gitgutter just staged for us
  - From here you can `:Gcommit` to commit or `<Leader>hu` to `h`unk `u`nstage

## Fun with fugitive
  - make change
  - `:Gw`
  - `:Gcommit`
  - `:0r!curl -s whatthecommit.com/index.txt`
  - `:wq`
  - `:Gpush`
  - giggle.

## Window management
- `ctrl+w` {up|down|left|right} moves cursor to window in that direction
- `ctrl+ww` move cursor to next window
- `ctrl+w ctrl+r` Rotate windows (swap windows when 2 are visible)

## Command history
  - `q /`, `q ?` new buffer with search history
  - `q :` new buffer with command history

## Marks
  - `m [a-z]` mark line in a-z register (per buffer) or A-Z register (global)
  - `m [A-Z]` mark line in A-Z register, but globally. Open ~/.vimrc, `mV`, `:q`, start new vim and type `'V` ... magic!
  - `' [a-z]` go to beginning of line at first non-whitespace character
  - '` [a-z]' back tick then register means "jump to line and column position." NOTE: this is really useful for macros!
  - '\`\`' that's two back ticks - jump to previous location

## Package management
Just use vundle because it supports all the other package managers and all you have to do is add {username}/{repo} from github to .vimrc then `'V:PluginInstall :so %` ('V = Open marked .vimrc then run :PluginInstall then run :source path-current-file)

## Utilities
- `ctrl+a` increment integer
- `ctrl+x` decrement integer
- `ictrl+r=7*1=` Do math in vim using the expression register (=) while in insert mode. Naturally, the first thing you should do with this information is divide a prime number (because they're awesome) by 0.

## Cursor
- Vim keeps pissing me off because the cursor jumps back 1 space from insert mode to nomal mode! YEP! BUT YOU WANT IT TO! Here's why: let's say we have a line with the word "test" and we want to change it to "test123." We could `A123` to change the text then *maybe do something with it.* Because the cursor jumps back we can efficiently yank or perform some other command. This is a contrived example, but hopefully that gets the point across. TODO: make an example that doesnt suck.

- Getting used to the block cursor can be a little annoying at first, but it's totally worth it because it's useful once you get in the groove. Just remember that hitting `i` will allow you to insert to the *left* of the cursor and `a` allow you to [a]ppend to the *right*

- When you mess up and leave some nasty white space at the end of a line, just `f ` (f space) to jump to it and deal with it with `x` or `diw` if there are multiple spaces. This also works for any other character you might accidentally leave somewhere in a line

## Search in a line or block of text
- `/\%Vsomething` will search for 'something' in:
  * Visual Mode: the highlighted text only.
  * Normal Mode: A sentence? TODO: not sure what the rules are, but this is really useful.

## Word wrapping
Word wrap seems to be a complicated topic in vim. There are resources with various strategies for how to handle wordwrapping, but while building this document (my first vim document), I have found 3 things that make this painless:
  1. `(` and `)` to jump from sentence to sentence.
  2. `f{char}` to move 'down lines'
  3. EasyMotion. It just kicks ass.

## Real world usage example with muttrc
I'm currently setting up mutt as my mail client because I must have vim bindings in all applications. I'm simply following a tutorial with a supplied muttrc that has placeholders. Here's what I'm doing for each line (and could probably do more efficiently):

```shell
set realname = "<first and last name>"
# `di"` delete in quotes, `iname` insert name
set from = "<gmail username>@gmail.com"
# used `j` to go down, cursor was inside angle brackets, so `da>` delete all bracket
set use_from = yes
set envelope_from = yes

set smtp_url = "smtps://jcaffey@gmail.com@smtp.gmail.com:465/"
# cursor before angle brackets, `f<da>` jump [f]orward to angle bracket <, delete all >, then just `iwhatever` to insert whatever.
set smtp_pass = "<app password>"
PROTIP: cursor landed on the last quote for me, but it doesn't need to for `di"` to work. This kicks major ass. I thought the cursor had to be in the quotes until I started writing this! No more f/F jumps!
set imap_user = "<gmail username>@gmail.com"
Update protip: `di<` doesn't work the same way `di"` does. I need to research this. For now I am doing `f<da>` to find the angle bracket and delete all.
set imap_pass = "<app password>"
# `di"` ... you get the idea.
```

## bang is your best friend
I've recently come to truly love and appreciate the Unix of "do one thing and do it well." The following are "vim tricks" using GNU/Linux tools that I think kick major ass.

## sorting
I have a private repository named "todo" that is just a collection of asciidoc files (because its better than markdown and vim is better than emacs and it's not even up for debate) that keep me sufficiently organized. This is what my repo currently looks like:

```shell
tree ~/repos/todo
.
├── crypto.adoc
├── csharp.adoc
├── dotfiles.md
├── email.md
├── repo.md
├── sugar.adoc
├── today.md
├── tomorrow.md
└── weekend.adoc
```

I'm still working out the kinks of my workflow with todo's, but let's take a look at email.md (still in the process of moving to adoc!) to see how this might work.

```shell
cat ~/repos/todo/email.md

##email
* [ ] add bin script for updating mbsync and msmtp password
* [x] update crontab to call mbsync
* [ ] 3
* [ ] 1
* [ ] 4
* [ ] 2
```

The todo's for 3,1,4, and 2 are contrived, but imagine you have a large list. I often find myself needing to prioritize and then re-prioritize each todo based on any number of factors. This helps me follow an iterative approach to development and the agile philosophy. That said, let's imagine that as I `j`/`k` up and down my document in the morning I realize that todo's 3 and 4 are now a much higher priority. I can `dd` then maybe `gg` to delete and then quickly get to the top of my document, but what I really want is to go through each line and assign them some priority.

It turns out that computers are great at sorting things so what I typically do is modify my list to look like this:

```md
##email
* [ ] add bin script for updating mbsync and msmtp password
* [x] update crontab to call mbsync
* [ ] - 3
* [ ] 1
* [ ] - 4
* [ ] 2
```
All I've done is added a `-` in front of the todo's that I know i want to get done today. Now I want those at the top of my list so it's as easy as `:%!sort`. Let's look at what that actually means.

- `:` enter ex command mode
- `%` current document (you can also use visual mode to select lines if you dont want to sort the entire document)
- `!` execute a shell command and if there is anything before the `!` pipe that data to it.
- `sort` the document. The output is automatically piped back in to vim. Very cool. Note: i also keep a cheat-sheets repository that comes in handy for common terminal commands that I can't keep in my head. See guides/cheat-sheets for more on that.

The result is a nice clean list with my priorities on top, completed tasks on bottom, and a happy me. From here I usually just order  todo's marked with `-` manually with `dd` and `p`.

```shell
##email
* [ ] - 3
* [ ] - 4
* [ ] 1
* [ ] 2
* [ ] add bin script for updating mbsync and msmtp password
* [x] update crontab to call mbsync
```
But why not just use lists, evernote, jira, or any other number of applications? Because my brain has ideas flying through all the time. I call these thoughts threads because it's a lot like a processor context switching. The sooner I kill a thread (get a thought out) the sooner I'm allocating all my processing power to the main thread (whatever i was working on originally).

For this idea to be effective I have to quickly get to my todo repository, insert an idea, and get back to whatever I was building. Doing that involved 3 tools: tmux, snip, and repo.

Tmux is a terminal multiplexer that kicks major ass and everyone should know about it. It allows me to have multiple workspaces open at one time.

Snip is just a simple ruby script that I have in my path under bin/snip that lets me add or show a snippet from my snippets repository.

Repo is another ruby script that allows me to manage my repositories quickly. I have a lot of ideas floating around for repo, but it's useful in this context because it allows me to open a repository *the way i want it to be opened*. For example, when want to open my dotfiles repo I just type `repo o dotfiles` and I don't need to worry about if it's located in my home directory or under my ~/repos directory. More importantly, I can tell repo *which* editor i want to open the repository with -- which is vim 99% of the time, but if I have another project for work I may need to open it in vscode. Repo is cool because it additionally supports arguments for the editor per repository. The ctrlp plugin for vim usually ignores dotfiles, but i need it to care about .zhsrc, .vimrc, etc ONLY when ive opened dotfiles. It's basically middleware for your text editor of choice.

Assuming that I am already in tmux working on a project, adding a todo to ~/repos/example.md would look like this:

- `ctrl+space` always use space for leader/prefix when possible. it's big and easy to get to for both hands.
- `c` to create a window in my tmux session
- `repo o todo` to open vim with the settings i want for ~/repos/todo
- select relevant document in nerdtree
- `:r!snip s todo.md` to tell vim to `r`ead the output of `snip show todo.md` which is literally just a file that has the contents: "* [ ]"

Most times I won't use snip and ill just `0yf]` to `0` go to beginning of line, `y`ank text until vim `f`inds the character `]` and then type `o<esc>p` to create a new line and `p`aste the "* [ ]" I just copied.

Marking a todo as done is as easy as `f[` or `F[` to `f`ind forward or `find` backwards the character `[` then type `lrx` and you're done. `l` moves right `rx` `r`eplaces the character with `x`.


## Resources
- vimtutor
- [Vim](https://www.youtube.com/watch?v=1lzXr-MztOU&list=PLy7Kah3WzqrEjsuvhT46fr28Q11oa5ZoI)
- [Graphical cheat sheet tutorial](http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html)
- [Vim + tmux](https://www.youtube.com/watch?v=5r6yzFEXajQ&t=1696s)
- [How to do 90% of what plugins do with just vim](https://www.youtube.com/watch?v=XA2WjJbmmoM&t=2670s)
- [VimAwesome.com](https://vimawesome.com/)
- [Vim tips on fandom](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
- [Vim registers](https://www.brianstorti.com/vim-registers/)
- [Folds cheat sheet](https://gist.github.com/lestoni/8c74da455cce3d36eb68)
- [Mutt Tutorial](https://medium.com/@itsjefftong/mutt-gmail-59447a4bffef)

## Folds
There are various fold methods, but I don't find this particularly interesting, so I'm just copying this cheat sheet for future reference.

- zj moves the cursor to the next fold.
- zk moves the cursor to the previous fold.
- zo opens a fold at the cursor.
- zO opens all folds at the cursor.
- zm increases the foldlevel by one.
- zM closes all open folds.
- zr decreases the foldlevel by one.
- zR decreases the foldlevel to zero -- all folds will be open.
- zd deletes the fold at the cursor.
- zE deletes all folds.
- [z move to start of open fold.
- ]z move to end of open fold.

[Folds](https://gist.github.com/lestoni/8c74da455cce3d36eb68)

## File management

### Moving files
`:NerdTreeFind` on open buffer will locate the document within nerdtree and give you the option to (m)ove file / update buffer.
`:Gmove` in a git repository
`:saveas` in plain old vim but you have to delete the other file!

### Searching files / project
`:Ag` search in files
`:FZF`/`:Files` find files by name

### Selection tricks
`gv` reselect last selection
`o` while in visual mode will move to the `o`pposite side of the selection. This allows you to add previous line(s) to your selection.

## TODO
* [ ] indentation + tabularize
* [ ] color scheme
* [ ] more on windows - size, hide, vsplit <filename>
* [ ] regular expressions
* [ ] macros
* [ ] ctrl i and o cursor history
* [ ] need a section on :h, :b, :ls, etc...
* [ ] i don't know what the hell this does, but look into gg=G for formatting
* [ ] talk about Leader l for line number with tmux
* [ ] add example for practical use of visual select + :w (aliases to individual files `gv` to reselect what was written then `d` then `yykp$bcwname-of-file`)
* [ ] w vs W, etc..
* [ ] `q:`, `q/` query?

Find a place for these:
  - Remove character `x` or `X` to remove character to the left
  - Replace mode `r`
  - `.` to repeat previous command
  - `ctrl+g` to new line and column that you are on
  - `~` swap character case
  - `:#` go to line number
