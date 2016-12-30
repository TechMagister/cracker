# cracker

Provide auto-completion for the crystal language ( racer like )

For Emacs integration see [TechMagister/emacs-cracker](https://github.com/TechMagister/emacs-cracker)
![Screenshot](https://github.com/TechMagister/emacs-cracker/raw/master/screenshot.png)

For Sublime Text integration see [TechMagister/CrystalAutoComplete](https://github.com/TechMagister/CrystalAutoComplete)
![screenshot1](https://raw.githubusercontent.com/TechMagister/CrystalAutoComplete/master/screenshots/screenshot1.png)

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
$ cracker client --help
Options:
  --add-path     Source path to add to completion database
  -p             Server port
                 (default: 1234)
  --starts-with  format : Class#method for instance method
                          Class.method for class method
  --context      Take a context in stdin
  --stop-server  Stop the server
  -h, --help     show this help
```

Example :

``` shell
$ cracker client --starts-with Array.e
```
Outputs all the Array class methods starting with e :
``` json
{
  "status": "success",
  "results": [
    {
      "name": "Array.each_product(arrays)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1138:3",
      "type": "Function",
      "signature": "def self.each_product(arrays)"
    },
    {
      "name": "Array.each_product(arrays : Array)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1162:3",
      "type": "Function",
      "signature": "def self.each_product(*arrays : Array)"
    }
  ]
}
```

```
$ cracker client --starts-with Array#e
```
Outputs all the Array instance methods starting with e :

``` json
{
  "status": "success",
  "results": [
    {
      "name": "Array#each_permutation(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":964:3",
      "type": "Function",
      "signature": "def each_permutation(size : Int = self.size)"
    },
...
    {
      "name": "Array#each_repeated_permutation(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1176:3",
      "type": "Function",
      "signature": "def each_repeated_permutation(size : Int = self.size)"
    }
  ]
}
```

``` shell
$ echo "@test : String\n@test.to_f" | cracker client --context
```

``` json
{
    "status": "success",
    "results": [
        {
            "name": "String#to_f(whitespace = true,strict = true)",
            "file": "/home/arnaud/workspace/repos/crystal/src/string.cr",
            "location": ":608:3",
            "type": "Function",
            "signature": "def to_f(whitespace = true, strict = true)"
        },
        {
            "name": "String#to_f?(whitespace = true,strict = true)",
            "file": "/home/arnaud/workspace/repos/crystal/src/string.cr",
            "location": ":626:3",
            "type": "Function",
            "signature": "def to_f?(whitespace = true, strict = true)"
        },
        {
            "name": "String#to_f32(whitespace = true,strict = true)",
            "file": "/home/arnaud/workspace/repos/crystal/src/string.cr",
            "location": ":631:3",
            "type": "Function",
            "signature": "def to_f32(whitespace = true, strict = true)"
        },
        {
            "name": "String#to_f32?(whitespace = true,strict = true)",
            "file": "/home/arnaud/workspace/repos/crystal/src/string.cr",
            "location": ":636:3",
            "type": "Function",
            "signature": "def to_f32?(whitespace = true, strict = true)"
        },
        {
            "name": "String#to_f64(whitespace = true,strict = true)",
            "file": "/home/arnaud/workspace/repos/crystal/src/string.cr",
            "location": ":644:3",
            "type": "Function",
            "signature": "def to_f64(whitespace = true, strict = true)"
        },
        {
            "name": "String#to_f64?(whitespace = true,strict = true)",
            "file": "/home/arnaud/workspace/repos/crystal/src/string.cr",
            "location": ":649:3",
            "type": "Function",
            "signature": "def to_f64?(whitespace = true, strict = true)"
        }
    ]
}

```

## Development

- [x] Allow to search using starts_with?
- [x] Add line number to the result
- [x] Replate type by a string
- [x] Daemonize
- [x] Append new source path for completion ( project path for instance )
- [x] Method completion
- [ ] Enum completion
- [ ] Macro completion
- [ ] Alias Completion
- [ ] Lib completion
- [ ] Constants completion
- [ ] IDE integration

## Contributing

1. Fork it ( https://github.com/TechMagister/cracker/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [TechMagister](https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
