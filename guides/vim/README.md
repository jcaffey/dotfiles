# THERE IS ONLY VIM

  TODO:
  indentation
  cleanup vim tutor
  color scheme
  more on windows - size, hide, vsplit <filename>
  regular expressions
  macros
  ctrl i and o cursor history
  TODO: need a section on :h, :b, :ls, etc...
  i don't know what the hell this does, but look into gg=G for formatting
  talk about Leader l for line number with tmux
# Buffers are better than tabs. I promise.
  Buffers are just files that vim has in memory. Any file you open will be listed in buffers unless you ask vim to get rid of it with `:bd{buffer-number}`. Here are the common buffer commands I use all the time.
  - `:ls` list buffers
  - `:b{buffer-number}` switch to that buffer. IMPORTANT: vim will ask if you want to save your changes to the file (if it has changed), press y or your changes are gone. You have been warned.
  - `:bd{buffer-number}` close buffer. NOTE: if you are editing a file and vim complains about the file being opened in another program (probably another instance of vim) this is the command you need to remove the buffer from vim.
  - `:vs#{buffer-number}` open buffer in vertical split

# Windows and multiple buffers
  TODO: bindings + tmux
  - `:vert h ctrlp-mappings` open help at ctrlp mappings in vertical split


# Thoughts on general setup and getting around a document
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

# Modes
  - `esc` Normal
  - `:` Command
  - `i` Insert
  - `R` Replace
  - `v` Visual
  - `ctrl+v` Visual Block
  - `V` Visual Line

# OMG HELP ME COMMANDS
  - `esc` to return to normal mode
  - `:q!` to quit without writing file and no prompt before quit
  - `u` undo
  - `ctrl+r` redo

# Commands
  - `d` delete (copy)
  - `c` change (delete then insert mode)
  - `y` yank (copy)
  - `v` visually select (visual mode)

# Text Objects
  - `w` words
  - `s` sentences
  - `p` paragraphs
  - `t` tags

# Motions
  - `a` all
  - `i` in
  - `t` 'til forward
  - `T` 'til backward
  - `f` find forward
  - `F` find backward

# Command Format
  {number of times}{command}{motion}{text object}

# Command history
  - `q /`, `q ?` new buffer with search history
  - `q :` new buffer with command history

# Marks
  - `m [a-z]` mark line in a-z register (per buffer) or A-Z register (global)
  - `m [A-Z]` mark line in A-Z register, but globally. Open ~/.vimrc, `mV`, `:q`, start new vim and type `'V` ... magic!
  - `' [a-z]` go to beginning of line at first non-whitespace character
  - '` [a-z]' back tick then register means "jump to line and column position." NOTE: this is really useful for macros!
  - '``' that's two back ticks - jump to previous location

# Common commands
  - `ctrl+o`, `ctrl+i` move forward and backward through jump history (especially useful when editing multiple methods)
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

# The magical %
  - `%` jump to matching parentheses, bracket, or curly brace.
  - `%` will jump to other *matching* items depending upon the programming language. See ruby example below.

  `%` jumps are marked with []
  [d]ef eql?[(]other[)]
    options = [{] verbose: true [}]

    [i]f other.is_a? String
      self.to_s == other || self.to_s[(]options[)] == other
    [e]lse
      self.to_s[(]options[)] == other.to_s[(]options[)]
    [e]nd
  [e]nd

  Given the method above, `:line-number-of-def` will place the cursor on the first line of the method declaration. `V` will highlight the line. `%` will highlight from the line to (and including) the end line. Now you can yank, change, or whatever you need to do. If you are indenting simply press `<` or `>` and then `.` to repeat indentation.

# Registers
  - The default or unnamed register is `"`
  - Registers 1-9 hold the text you have yanked/deleted, so you never really lose anything.
  - Use `:reg` or `:registers` to see what the registers hold.
  - In insert mode you can `ctrl+r "` to paste from default register
  - In normal mode you can `"1p` which means grab register 1 and paste
  - `ayiw` yank in word to the a register

  - Update .vimrc with the following:
  " Allow copy/paste between vims and system by setting the clipboard to be unnamed register.
  set clipboard^=unnamed

  Excellent article covering registers in detail:
  <https://www.brianstorti.com/vim-registers/>

# Movement
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

# TODO: find place for these.
  - Remove character `x` or `X` to remove character to the left
  - Replace mode `r` 
  - `.` to repeat previous command
  - `ctrl+g` to new line and column that you are on
  - `~` swap character case
  - `:#` go to line number

# Lines
  - `I` insert at beginning of line
  - `A` insert at end of line
  - `O` Open new line above and switch to insert mode
  - `o` Open new line below and switch to insert mode
  - `D` Delete til end of line
  - `d0` Delete to beginning of line
  - `C` Change til end of line
  - `shift+{left|right}-arrow` to jump between words (works in normal and insert modes)
  - `<` and `>` tab left and right respectively
  - Jump to end of line - `end` or regex syntax ($)
    -`g_` go to last non-blank character of line
  - Jump to beginning of line - `0` for hard beginning of line and regex syntax (^) for soft beginning of line
    - `g0` go to first non-blank character
  - `#G` move cursor to specified line number

# Words
  - `w` beginning of word
  - `e` end of word
  - `b` previous word

# Vimtutor Lessons
                          Lesson 4.2: THE SEARCH COMMAND


       ** Type  /  followed by a phrase to search for the phrase. **

    1. In Normal mode type the  /  character.  Notice that it and the cursor
       appear at the bottom of the screen as with the  :  command.

    2. now type 'errroor' <enter>.  this is the word you want to search for.

    3. to search for the same phrase again, simply type  n .
       to search for the same phrase in the opposite direction, type  n .

    4. to search for a phrase in the backward direction, use  ?  instead of  / .

    5. to go back to where you came from press  ctrl-o  (keep ctrl down while
       pressing the letter o).  repeat to go back further.  ctrl-i goes forward.

  --->  "errroor" is not the way to spell error;  errroor is an error.
  note: when the search reaches the end of the file it will continue at the
        start, unless the 'wrapscan' option has been reset.


                        lesson 4.4: the substitute command


          ** type  :s/old/new/g  to substitute 'new' for 'old'. **

    1. Move the cursor to the line below marked --->.

    2. Type  :s/thee/the <ENTER>  .  Note that this command only changes the
       first occurrence of "thee" in the line.

    3. Now type  :s/thee/the/g .  Adding the  g  flag means to substitute
       globally in the line, change all occurrences of "thee" in the line.

  ---> thee best time to see thee flowers is in thee spring.

    4. To change every occurrence of a character string between two lines,
       type   :#,#s/old/new/g    where #,# are the line numbers of the range
                                 of lines where the substitution is to be done.
       Type   :%s/old/new/g      to change every occurrence in the whole file.
       Type   :%s/old/new/gc     to find every occurrence in the whole file,
                                 with a prompt whether to substitute or not.


                  Lesson 5.1: HOW TO EXECUTE AN EXTERNAL COMMAND


     ** Type  :!  followed by an external command to execute that command. **

    1. Type the familiar command  :  to set the cursor at the bottom of the
       screen.  This allows you to enter a command-line command.

    2. Now type the  !  (exclamation point) character.  This allows you to
       execute any external shell command.

    3. As an example type   ls   following the ! and then hit <ENTER>.  This
       will new you a listing of your directory, just as if you were at the
       shell prompt.  Or use  :!dir  if ls doesn't work.

  NOTE:  It is possible to execute any external command this way, also with
         arguments.

  NOTE:  All  :  commands must be finished by hitting <ENTER>
         From here on we will not always mention it.


                      Lesson 5.3: SELECTING TEXT TO WRITE


          ** To save part of the file, type  v  motion  :w FILENAME **

    1. Move the cursor to this line.

    2. Press  v  and move the cursor to the fifth item below.  Notice that the
       text is highlighted.

    3. Press the  :  character.  At the bottom of the screen  :'<,'> will appear.

    4. Type  w TEST  , where TEST is a filename that does not exist yet.  Verify
       that you see  :'<,'>w TEST  before you press <ENTER>.

    5. Vim will write the selected lines to the file TEST.  Use  :!dir  or  :!ls
       to see it.  Do not remove it yet!  We will use it in the next lesson.

  NOTE:  Pressing  v  starts Visual selection.  You can move the cursor around
         to make the selection bigger or smaller.  Then you can use an operator
         to do something with the text.  For example,  d  deletes the text.


                     Lesson 5.4: RETRIEVING AND MERGING FILES


         ** To insert the contents of a file, type  :r FILENAME  **

    1. Place the cursor just above this line.

  NOTE:  After executing Step 2 you will see text from lesson 5.3.  Then move
         DOWN to see this lesson again.

    2. Now retrieve your TEST file using the command   :r TEST   where TEST is
       the name of the file you used.
       The file you retrieve is placed below the cursor line.

    3. To verify that a file was retrieved, cursor back and notice that there
       are now two copies of lesson 5.3, the original and the file version.

  NOTE:  You can also read the output of an external command.  For example,
         :r !ls  reads the output of the ls command and puts it below the
         cursor.


                          Lesson 6.4: COPY AND PASTE TEXT


            ** Use the  y  operator to copy text and  p  to paste it **

    1. Move to the line below marked ---> and place the cursor after "a)".

    2. Start Visual mode with  v  and move the cursor to just before "first".

    3. Type  y  to yank (copy) the highlighted text.

    4. Move the cursor to the end of the next line:  j$

    5. Type  p  to put (paste) the text.  Then type:  a second <ESC> .

    6. Use Visual mode to select " item.", yank it with  y , move to the end of
       the next line with  j$  and put the text there with  p .

  --->  a) this is the first item.
        b) this is the first item.


    NOTE: You can also use  y  as an operator;  yw  yanks one word.


            ** Set an option so a search or substitute ignores case **

    1. Search for 'ignore' by entering:  /ignore <ENTER>
       Repeat several times by pressing  n .

    2. Set the 'ic' (Ignore case) option by entering:   :set ic

    3. Now search for 'ignore' again by pressing  n
       Notice that Ignore and IGNORE are now also found.

    4. Set the 'hlsearch' and 'incsearch' options:  :set hls is

    5. Now type the search command again and see what happens:  /ignore <ENTER>

    6. To disable ignoring case enter:  :set noic

  NOTE:  To remove the highlighting of matches enter:   :nohlsearch
  NOTE:  If you want to ignore case for just one search command, use  \c
         in the phrase:  /ignore\c <ENTER>

# Working with chunks of text
  For the next three exercises, move your cursor to the line of the instruction text before selecting text.

  1. Select the text between ---- with `5j V 9j`
  2. Select the text between "hashes = [" and "]" with `7j % vi]`
  3. Select only id numbers with `4j 0 f0 ctrl+v 7j`

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

    { id: 0, name: "foo 0" },
    { id: 1, name: "foo 1" },
    { id: 2, name: "foo 2" },
    { id: 3, name: "foo 3" },
    { id: 4, name: "foo 4" },
    { id: 5, name: "foo 5" },
    { id: 6, name: "foo 6" },
    { id: 7, name: "foo 7" }
  ----------------------------------------
# Splitting lines
  Split a line with: `f ` to get to whitespace, `ciw` kill whitespace, `return`
  left side |  right side

# Plugins that make you unstoppable
  * EasyMotion - This is, by far, the coolest and fastest way to navigate a document. EasyMotion asks you what you are looking for and then puts anchor points in the window to jump to the location matching the characters you provided. If you need to move more than a few lines this is way faster than using relative line numbers to jump up or down. This is what makes my preferred strategy for word wrapping work. See word wrapping.

  [EasyMotion](https://github.com/easymotion/vim-easymotion)
  ![EasyMotion][https://camo.githubusercontent.com/d5f800b9602faaeccc2738c302776a8a11797a0e/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f333739373036322f323033393335392f61386539333864362d383939662d313165332d383738392d3630303235656138333635362e676966]

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

   Use repeat.vim to repeat the surround command (it works out of the box). `ysiw"` to surround test with ". then `b."` to jump to [b]eginning of previous word and repeat with . then enter character ".
  test test -> "test" "test"

* Airline - Every vim user has this. It's pretty and it displays useful info. My .vimrc also has tmuxline installed which uses the theme from airline.

* CtrlP - Fuzzy find your files
`ctrl+p` as the name suggests will open a fuzzy search and list any files that match. By default it will start indexing files from where you started vim. You can use `:pwd` to find out where you are and `:cd path/to/something` if you want to change it.

# Window management
- `ctrl+w` {up|down|left|right} moves cursor to window in that direction
- `ctrl+ww` move cursor to next window
- `ctrl+w ctrl+r` Rotate windows (swap windows when 2 are visible)

# Substitution (search and replace)
- the g modifier probably doesn't work like you think it does. it means global *for each line*

# Package management
Just use vundle because it supports all the other package managers and all you have to do is add {username}/{repo} from github to .vimrc then `'V:PluginInstall :so %` ('V = Open marked .vimrc then run :PluginInstall then run :source path-current-file)

TODO: `q:`, `q/` query?

# Utilities
- `ctrl+a` increment integer
- `ctrl+x` decrement integer
- `ictrl+r=7*1=` Do math in vim using the expression register (=) while in insert mode. Naturally, the first thing you should do with this information is divide a prime number (because they're awesome) by 0.

# Cursor
- Vim keeps pissing me off because the cursor jumps back 1 space from insert mode to nomal mode! YEP! BUT YOU WANT IT TO! Here's why: let's say we have a line with the word "test" and we want to change it to "test123." We could `A123` to change the text then *maybe do something with it.* Because the cursor jumps back we can efficiently yank or perform some other command. This is a contrived example, but hopefully that gets the point across. TODO: make an example that doesnt suck.

- Getting used to the block cursor can be a little annoying at first, but it's totally worth it because it's useful once you get in the groove. Just remember that hitting `i` will allow you to insert to the *left* of the cursor and `a` allow you to [a]ppend to the *right*

- When you mess up and leave some nasty white space at the end of a line, just `f ` (f space) to jump to it and deal with it with `x` or `diw` if there are multiple spaces. This also works for any other character you might accidentally leave somewhere in a line

# Search in a line or block of text
- `/\%Vsomething` will search for 'something' in:
  Visual Mode: the highlighted text only.
  Normal Mode: A sentence? TODO: not sure what the rules are, but this is really useful.

# Word wrapping
Word wrap seems to be a complicated topic in vim. There are resources with various strategies for how to handle wordwrapping, but while building this document (my first vim document), I have found 3 things that make this painless:
  1. `(` and `)` to jump from sentence to sentence.
  2. `f{char}` to move 'down lines'
  3. EasyMotion. It just kicks ass.

# Resources
- vimtutor
- Vim <https://www.youtube.com/watch?v=1lzXr-MztOU&list=PLy7Kah3WzqrEjsuvhT46fr28Q11oa5ZoI>
- Graphical cheat sheet tutorial <http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html>
- Vim + tmux <https://www.youtube.com/watch?v=5r6yzFEXajQ&t=1696s>
- How to do 90% of what plugins do with just vim <https://www.youtube.com/watch?v=XA2WjJbmmoM&t=2670s>
- VimAwesome.com <https://vimawesome.com/>
- Vim tips on fandom <https://vim.fandom.com/wiki/Vim_Tips_Wiki>
- Vim registers <https://www.brianstorti.com/vim-registers/>
- Folds cheat sheet <https://gist.github.com/lestoni/8c74da455cce3d36eb68>

# Folds
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

<https://gist.github.com/lestoni/8c74da455cce3d36eb68>
