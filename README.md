# cracker

Provide auto-completion for the crystal language ( racer like ) [WIP]

## Installation

- Clone the repository
- Build
- Copy the binary to your $PATH

## Usage
Start the server

``` shell
cracker server /path/to/crystal/source
```

And query :

``` shell
cracker client --starts-with String#starts

```
Output :
``` json
[
  {
    "name": "String#starts_with?(str : String)",
    "file": "/path/to/crystal/source/string.cr",
    "location": ":3261:3",
    "type": "Function",
    "signature": "def starts_with?(str : String)"
  },
  {
    "name": "String#starts_with?(char : Char)",
    "file": "/path/to/crystal/source/string.cr",
    "location": ":3266:3",
    "type": "Function",
    "signature": "def starts_with?(char : Char)"
  }
]
```

TODO : Integration with IDEs ( emacs first :) )

## Development

- [x] Allow to search using starts_with?
- [x] Add line number to the result
- [x] Replate type by a string
- [x] Daemonize
- [ ] Append new source path for completion ( project path for instance )
- [ ] Give a file path to the server, line number and character number to complete with the context ?

## Contributing

1. Fork it ( https://github.com/TechMagister/cracker/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [TechMagister](https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
