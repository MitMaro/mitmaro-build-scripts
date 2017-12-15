# MitMaro's Build Scripts

A set of Bash functions that can be used in building projects.

## Install

### npm

    npm install --save[-dev] @mitmaro/build-scripts

### Yarn

Install the package using yarn:

    yarn add @mitmaro/build-scripts


## Usage

Create a file to source the build-scripts that contains the following, selecting `npm` or `yarn`:

    #!/usr/bin/env bash
    source "$(npm|yarn bin)/build-scripts.bash" || exit 1
    

On the top of the script files add the following to source the file created above, replacing `./common.bash` with the
relative path to the file created above.

    #!/usr/bin/env bash
    cd "$(dirname "${BASH_SOURCE[0]}")" && source "./common.bash"
    

## API

### `debug|info|warn|error <message>...`

Prints a formatted message of type debug, info, warning or error.

`error` will print message to `stderr` instead of `stdout`.

#### Example

```
debug "My debug" "message" 
info "My info" "message"
warn "My warning" "message"
error "My error" "message"
```

### `hl <message>`

Prints a highlighted message.

#### Example

    info "Print $(hl "foobar") as highlighted"

### `fatal message [<exit_code>]`

Prints a message using the `error` function and then exits is a non-zero `exit_code` is provided. If the optional
`exit_code` argument is not provided, the last commands exit code will be used.

#### Example

    # Print error message and exits with code 22
    fatal "An error occurred" 22
    
    # Usage as an error handler
    my_command || fatal "my_command failed"
    

### `set-log-level <level>`

Sets the logging level to the provided `level`. A log function will only output when the level is at or above the level
of the function. The levels go from `debug` -> `info` -> `warn` -> `error` -> `fatal` and defaults to `info`. 

#### Example

    set-log-level "warn"

### `set-log-name <name>`

Sets a logging name for this process that will be printed before every log output. It will automatically surrounded like
`[<name>]`. By default no logging name will be used.

#### Example

    set-log-name "my-process.1"

### `clear-log-name`

Clears the logging name.

#### Example

    clear-log-name

### `check-command <command>`

Checks if the command provided as `command` exists, if not found the script will exit with `EXIT_CODE_INVALID_STATE`.

#### Example

```
check-command "node"
```

### `ensure-directory <directory>`

Checks if the directory at `directory` exists, if not it will be recursively created.

#### Example

```
ensure-directory "build/coverage/"
```

### `include <file-path>`

Sources `file-path`, where `file-path` is relative to `$PWD` or the include path as set by `set-include-path`.

#### Example

```
include "common/libs.bash"
```

### `set-include-path <path>`

Sets the path that is used as a base for the `include` function.

#### Example

```
set-include-path "$(npm prefix)/scripts/"
```

### `get-project-root <project-type>`

Prints the root of the project for the given project type.

Supported project types:

- `node` : Looks up from current directory for `package.json`

If the project root cannot be found, nothing will be printed and `false` will be returned.

If an invalid `project-type` is provided the script will exit with `EXIT_CODE_INVALID_STATE`.

#### Example

```
project_root="$(get-project-root node)"
```

### `load-environment-file <filepath>`

Loads an environment file of key value pairs without over writting existing values. The format of the environment
variable files follows "[section 3.2.2. Creating variables](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html)".

#### Example

```
load-environment-file .env
```

### `process-run <command> <name> <working-directory> [<process-arguments>...]`

Safely starts the provided `command` with a unique provided `name` from the given `working-directory`. Additional
arguments can be provided as `process-arguments`. The process will be started with a pid file generated allowing it to
be killed at a later time. The `pid-file` will be created in `working-directory` with a file name of `<name>.pid`.

#### Example

```
process-run "node" "server-$PORT" "$PWD" "process-file.js" "file.csv"
```

### `shutdown-process <pid-file>`

Kill the process references in the provided `pid-file` waiting for it to properly exit. The `pid-file` is generally
created with the `process-run` function.

#### Example

```
shutdown "build/server-$PORT.pid"
```

### `yn <value>`

Parses the provided `value` and does a case-insensitive comparision against `y`, `yes`, `true` and `1` and returns
`true` if there is a match, else a `false` is returned.

#### Example

```
yn "yes" # returns true
yn "no"  # returns false
```

### `init-node`

Initializes the build scripts as a node project. This will add the `node_modules` bin directory to the path and change
into the node project root.

## Error Codes

| Name                      | Description            | Value  |
|---------------------------|------------------------|:------:|
| `EXIT_CODE_INCLUDE_ERROR` | Error including a file |   20   |
| `EXIT_CODE_INVALID_STATE` | Invalid script state   |   21   |


## License

This project is released under the ISC license. See [LICENSE](LICENSE).
