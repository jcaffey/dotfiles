TODO: gitignore everything except example

# Ignore everything except gitkeeps in backup/swap/undo
vim/.vim/.backup
vim/.vim/.swp
vim/.vim/.undo
!vim/.vim/.backup/.gitkeep
!vim/.vim/.swp/.gitkeep
!vim/.vim/.undo/.gitkeep

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
