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
create a copy of this repository with a clean git history. log in to GitHub and click the green "Use this template" button at the top of the repository page.

- clone your repository to your local computer
- initialize the godot-cpp git submodule via git submodule update --init

- change the name of the compiled library file inside the [SConstruct](https://github.com/zenksoo/custom-gdcpp-template/blob/master/SConstruct) file by modifying the libname string.

    - change the paths of the to be loaded library name inside the [game-project/bin/example.gdextension](https://github.com/zenksoo/custom-gdcpp-template/blob/master/game-project/bin/example.gdextension) file, by replacing EXTENSION-NAME with the name you chose for libname.

- change the entry_symbol string inside [project/bin/example.gdextension](https://github.com/zenksoo/custom-gdcpp-template/blob/master/game-project/bin/example.gdextension) file.

    - rename the example_library_init function in [src/register_types.cpp](https://github.com/zenksoo/custom-gdcpp-template/blob/master/src/register_types.cpp) to the same name you chose for entry_symbol.

change the name of the `project/bin/example.gdextension` file


Now, you can build the project with the following command at root directory:

```
scons
```

## Configuring an IDE

You can develop your own extension with any text editor and by invoking scons on the command line, but if you want to work with an IDE (Integrated Development Environment), you can use a compilation database file called compile_commands.json. Most IDEs should automatically identify this file, and self-configure appropriately. To generate the database file, you can run one of the following commands in the project root directory:

```shell
# Generate compile_commands.json while compiling
scons compiledb=yes
```
```shell
# Generate compile_commands.json without compiling
scons compiledb=yes compile_commands.json
```
