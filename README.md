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
$ cracker client --help
Options:
  --add-path     Source path to add to completion database
  -p             Server port
                 (default: 1234)
  --starts-with  format : Class#method for instance method
                          Class.method for class method
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
    {
      "name": "Array#each_permutation(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1009:3",
      "type": "Function",
      "signature": "def each_permutation(size : Int = self.size)"
    },
    {
      "name": "Array#each_combination(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1023:3",
      "type": "Function",
      "signature": "def each_combination(size : Int = self.size)"
    },
    {
      "name": "Array#each_combination(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1059:3",
      "type": "Function",
      "signature": "def each_combination(size : Int = self.size)"
    },
    {
      "name": "Array#each_repeated_combination(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1087:3",
      "type": "Function",
      "signature": "def each_repeated_combination(size : Int = self.size)"
    },
    {
      "name": "Array#each_repeated_combination(size : Int = self.size)",
      "file": "/path/to/crystal/source/array.cr",
      "location": ":1120:3",
      "type": "Function",
      "signature": "def each_repeated_combination(size : Int = self.size)"
    },
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

## Development

- [x] Allow to search using starts_with?
- [x] Add line number to the result
- [x] Replate type by a string
- [x] Daemonize
- [x] Append new source path for completion ( project path for instance )
- [ ] IDE integration

## Contributing

1. Fork it ( https://github.com/TechMagister/cracker/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [TechMagister](https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
