# record a macro
q{some-key-for-register}
do stuff
q

# play a macro
@{some-key-register}

# Repeat last macro!
`@@`

# Create a macro to change each attribute value to "test"
1. Move cursor to line
2. qq
3. f"
4. l
5. ct"
6. test
7. q

<element tag="" tag2="" tag3="" />

# Marking lines while recording a macro
1. Move to line in normal mode
2. `m` to mark
3. `any-key` to pick mark register
4. `any-key to jump to line

# Common commands
- `ctrl+a` to increment a number

Create an array of hashes in ruby with id's from 0 to n
- Mark number (mark1)
- Start on line above
- o
- Mark new line (mark2)
- `mark1
- yiw
- ctrl+a
- `mark2
- enter text / paste
- `#@q`
- `mark1 `dd`

23
hashes = [
  { id: 0, name: "Foo 0" },
  { id: 1, name: "Foo 1" },
  { id: 2, name: "Foo 2" },
  { id: 3, name: "Foo 3" },
  { id: 4, name: "Foo 4" },
  { id: 5, name: "Foo 5" },
  { id: 6, name: "Foo 6" },
  { id: 7, name: "Foo 7" },
  { id: 8, name: "Foo 8" },
  { id: 9, name: "Foo 9" },
  { id: 10, name: "Foo 10" },
  { id: 11, name: "Foo 11" },
  { id: 12, name: "Foo 12" },
  { id: 13, name: "Foo 13" },
  { id: 14, name: "Foo 14" },
  { id: 15, name: "Foo 15" },
  { id: 16, name: "Foo 16" },
  { id: 17, name: "Foo 17" },
  { id: 18, name: "Foo 18" },
  { id: 19, name: "Foo 19" },
  { id: 20, name: "Foo 20" },
  { id: 21, name: "Foo 21" },
  { id: 22, name: "Foo 22" }
]



## real world example: making a bufexplorer cheat sheet from their documentation

Text from github:
##bufexplorer
'be' (normal open) or 'bt' (toggle open / close) or 'bs' (force horizontal split open) or 'bv' (force vertical split open)

Text after after replacing or with carriage return using: `:s/or /\r/g` (notice space at end of each line!)
##bufexplorer
'be' (normal open) 
'bt' (toggle open / close) 
'bs' (force horizontal split open) 
'bv' (force vertical split open)

Text after recording and executing macro: 
- `gg` (top of document, so cursor is on line with '##bufexplorer') 
- `qq` record macro on register q
- `j0` go down one line and then to the beginning of the line. it's important to always think about where you are in an abstract way when recording a macro. rather than thinking in terms of line x, column y it would be better to think about line x and some word, beginning of line, end of line, etc.. this just becomes second nature over time.
- `cs'`` change surrounding single quotes to backticks
- `:s/ $//` remove the space at the end of the line
- `q3@q` stop recording macro and execute macro on register q 3 times (i know it's 3 because i can quickly look at the hybrid numbers vim is showing me)

This may seem like a lot of steps but I've been using vim for about a month and I was able to do this quickly even though I'm very tired because my allergies suck and I have taken zyretc. :)
