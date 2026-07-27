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
