#Settings
TARGET_EXEC := main
TARGET_DIR := bin
BUILD_DIR := build
SRC_DIRS := src libs

SRC := $(shell find $(SRC_DIRS) -name '*.cpp')
OBJS := $(SRC:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CC := clang++
CFLAGS := $(INC_FLAGS) -MMD -MP -std=c++23 -O3 -Wall -Wextra #-WebKit is macos specific, so if looking for cross-compat, change this to something else.
LDLIBS := -ldl
LDFLAGS := -framework WebKit
CDEFS :=

#'make DEBUG=1'. Also can use 'make debug'.
ifdef DEBUG
	CFLAGS += -g3 -DDEBUG -O0
endif

#Colors
ifndef VIM
	RED := \033[38;2;255;0;0m
	YELLOW := \033[38;2;255;255;0m
	GREEN := \033[38;2;21;204;4m
	NC := \033[0m
endif

#Building
$(TARGET_DIR)/$(TARGET_EXEC): $(OBJS)
	@mkdir -p $(dir $@)
	@$(CC) $(OBJS) -o $(TARGET_DIR)/$(TARGET_EXEC) $(LDFLAGS) $(LDLIBS) && \
		printf '\n  $(GREEN)Compiled binary$(NC): %s\n' $@

$(BUILD_DIR)/%.cpp.o: %.cpp
	@mkdir -p $(dir $@)
	@printf '  $(YELLOW)Compiling$(NC): %s\n' $@
	@$(CC) $(CFLAGS) $(CDEFS) -c $< -o $@

#Commands
.PHONY: clean debug libs run
clean: 
	@printf '  $(RED)rm -r$(NC) %s %s\n' $(BUILD_DIR)/ $(TARGET_DIR)/
	@rm -r build/ bin/ 2>/dev/null || true

debug:
	@$(MAKE) clean
	@$(MAKE) DEBUG=1
	@gdb bin/main

libs:
	@./scripts/clean.sh
	@./scripts/setup.sh

run: $(TARGET_DIR)/$(TARGET_EXEC)
	@./$(TARGET_DIR)/$(TARGET_EXEC)

-include $(DEPS)
