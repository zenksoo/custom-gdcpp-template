# path to u excutable godot engine in u computer
GODOT = $(HOME)/zenkso/apps/godot/Godot_v4.7-stable_linux.x86_64

# Detect platform
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    PLATFORM := linux
endif
ifeq ($(UNAME_S),Darwin)
    PLATFORM := macos
endif

# Windows via MSYS/MinGW reports differently, adjust if you ever build there
ifneq (,$(findstring MINGW,$(UNAME_S)))
    PLATFORM := windows
endif

# Detect architecture

UNAME_M := $(shell uname -m)
ifeq ($(UNAME_M),x86_64)
    ARCH := x86_64
endif
ifeq ($(UNAME_M),aarch64)
    ARCH := arm64
endif
ifeq ($(UNAME_M),arm64)
    ARCH := arm64
endif

# buid target and u can override with `make TARGET=template_release`
TARGET ?= template_debug

SRC := $(shell find src -name '*.cpp')
DEP := $(shell find src -type f -name '*.d')
HEADERS := $(shell find src -type f -name '*.hpp')

OBJ := $(SRC:.cpp=.o)

LIB_NAME := EXTENSION-NAME
TARGET_DIR := game-project/bin/$(PLATFORM)
TARGET_LIB := $(TARGET_DIR)/lib$(LIB_NAME).$(PLATFORM).$(TARGET).$(ARCH).so



GODOT_CPP_LIB := godot-cpp/bin/libgodot-cpp.$(PLATFORM).$(TARGET).$(ARCH).a

CXX := g++
CXXFLAGS := -std=c++17 -fPIC -Isrc \
			-Igodot-cpp/include \
			-Igodot-cpp/gen/include \
			-Igodot-cpp/gdextension \
			-DHOT_RELOAD_ENABLED


$(TARGET_LIB): $(OBJ) $(HEADERS)
	mkdir -p $(TARGET_DIR)
	$(CXX) -shared -o $@ $(OBJ) $(GODOT_CPP_LIB)
	$(GODOT) --path game-project


help:
	@echo "Available targets:"
	@echo "  make lib        Build the godot-cpp static library"
	@echo "  make compiledb  Generate compile_commands.json for clangd"
	@echo "  make            Build your game module (default target)"
	@echo "  make clean      Remove build artifacts (.o/.d)"
	@echo "  make distclean  Deep clean, including orphaned files"


lib:
	scons -C godot-cpp target=$(TARGET) platform=$(PLATFORM) compiledb=yes use_hot_reload=yes


compiledb:
	mv godot-cpp/compile_commands.json ./


clean:
	@rm -rf $(OBJ) $(DEP)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

-include $(SRC:.cpp=.d)
