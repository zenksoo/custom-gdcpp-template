# **custom godot-cpp template**
A personal, ready-to-clone template for building Godot 4 games with C++ (GDExtension),

customized for my own workflow.

## content

- `godot-cpp` bindings, buildable against multiple Godot 4.x versions
- SCons build configuration for Windows/Linux/macOS
- A clean, opinionated folder structure (`src/`, `gameProject/`, `bin/`)
- A working Player example GDExtension class, ready to replace with real gameplay code
- Version-switch notes for pinning the submodule to a specific Godot release

## Usage - Template
Create a copy of this repository with a clean git history. Log in to GitHub and click the green "Use this template" button at the top of the repository page.


- clone your repository to your local computer
- initialize the godot-cpp git submodule via `git submodule update --init`

- change the name of the compiled library file inside the [Makefile](https://github.com/zenksoo/custom-gdcpp-template/blob/master/Makefile) file by modifying the LIB_NAME string.

    - change the paths of the to be loaded library name inside the [game-project/bin/example.gdextension](https://github.com/zenksoo/custom-gdcpp-template/blob/master/game-project/bin/example.gdextension) file, by replacing EXTENSION-NAME with the name you chose for libname.

- change the entry_symbol string inside [project/bin/example.gdextension](https://github.com/zenksoo/custom-gdcpp-template/blob/master/game-project/bin/example.gdextension) file.

    - rename the example_library_init function in [src/register_types.cpp](https://github.com/zenksoo/custom-gdcpp-template/blob/master/src/register_types.cpp) to the same name you chose for entry_symbol.

change the name of the `project/bin/example.gdextension` file


### Building

This project uses a `Makefile` on top of godot-cpp's SCons build — SCons builds the godot-cpp static library and generates the compile database; Make compiles and links your own game module against it.

Build everything from the project root:

```bash
make lib          # builds the godot-cpp static library + compile_commands.json
make               # compiles src/ and links the final shared library
```

Or in one go:
```bash
make lib && make
```

Other available commands:

| Command | Description |
|---|---|
| `make lib` | Build the godot-cpp static library (`use_hot_reload=yes`) and regenerate `compile_commands.json` for clangd |
| `make` | Compile your `src/` sources and link the final `.so`/`.dll` |
| `make run` | Launch the project's main scene via the Godot binary |
| `make run-headless` | Launch headless — useful for a quick load/crash smoke-test |
| `make clean` | Remove `.o`/`.d` build artifacts |
| `make distclean` | Deep clean, including any orphaned build files |
| `make help` | List all available targets |

Override the build target/platform if needed:
```bash
make lib TARGET=template_release
```

### Running

* Import the game project into Godot Engine, open the player scene, and run it — you'll have a player with top-down movement ready to go.
* Alternatively, run `make run` from the terminal once the library is built.

## Configuring an IDE

You can develop your own extension with any text editor and by invoking scons on the command line, but if you want to work with an IDE (Integrated Development Environment), you can use a compilation database file called compile_commands.json. Most IDEs should automatically identify this file, and self-configure appropriately. To generate the database file, you can run  the following command in the project root directory:

```shell
# Generate compile_commands.json
make compiledb
```

and then `CTRL+SHIFT+P` and search for `>clangd: Restart language server` and press `Enter`

