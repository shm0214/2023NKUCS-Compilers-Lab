SRC_PATH ?= src
INC_PATH += include
BUILD_PATH ?= build
TEST_PATH ?= test
OBJ_PATH ?= $(BUILD_PATH)/obj
BINARY ?= $(BUILD_PATH)/compiler
SYSLIB_PATH ?= sysyruntimelibrary

INC = $(addprefix -I, $(INC_PATH))
SRC = $(shell find $(SRC_PATH)  -name "*.cpp")
CFLAGS = -O0 -g -Wall -Werror $(INC)
FLEX ?= $(SRC_PATH)/lexer.l
LEXER ?= $(addsuffix .cpp, $(basename $(FLEX)))
BISON ?= $(SRC_PATH)/parser.y
PARSER ?= $(addsuffix .cpp, $(basename $(BISON)))
SRC += $(LEXER)
SRC += $(PARSER)
OBJ = $(SRC:$(SRC_PATH)/%.cpp=$(OBJ_PATH)/%.o)
PARSERH ?= $(INC_PATH)/$(addsuffix .h, $(notdir $(basename $(PARSER))))

TESTCASE = $(shell find $(TEST_PATH) -name "*.sy")
LLVM_IR = $(addsuffix _std.ll, $(basename $(TESTCASE)))
OUTPUT_LAB4 = $(addsuffix .toks, $(basename $(TESTCASE)))
OUTPUT_LAB5 = $(addsuffix .ast, $(basename $(TESTCASE)))
OUTPUT_LAB6 = $(addsuffix .ll, $(basename $(TESTCASE)))

.phony:all app run gdb testlab4 testlab5 testlab6 llvmir clean 

all:app

$(LEXER):$(FLEX)
	@flex -o $@ $<

$(PARSER):$(BISON)
	@bison -o $@ $< --warnings=error=all --defines=$(PARSERH)

$(OBJ_PATH)/%.o:$(SRC_PATH)/%.cpp
	@mkdir -p $(OBJ_PATH)
	@g++ $(CFLAGS) -c -o $@ $<

$(BINARY):$(OBJ)
	@g++ -O0 -g -o $@ $^

app:$(LEXER) $(PARSER) $(BINARY)

run:app
	@$(BINARY) -o example.ll -i example.sy

gdb:app
	@gdb $(BINARY)

$(OBJ_PATH)/lexer.o:$(SRC_PATH)/lexer.cpp
	@mkdir -p $(OBJ_PATH)
	@g++ $(CFLAGS) -c -o $@ $<

$(TEST_PATH)/%.toks:$(TEST_PATH)/%.sy
	@$(BINARY) $< -o $@ -t

$(TEST_PATH)/%.ast:$(TEST_PATH)/%.sy
	@$(BINARY) $< -o $@ -a

$(TEST_PATH)/%.ll:$(TEST_PATH)/%.sy
	@$(BINARY) $< -o $@ -i	

$(TEST_PATH)/%_std.ll:$(TEST_PATH)/%.sy
	@clang -x c $< -S -m32 -emit-llvm -o $@ 

llvmir:$(LLVM_IR)

testlab4:app $(OUTPUT_LAB4)

testlab5:app $(OUTPUT_LAB5)

testlab6:app $(OUTPUT_LAB6)

clean:
	@rm -rf $(BUILD_PATH) $(PARSER) $(LEXER) $(PARSERH) $(OUTPUT_LAB4) $(OUTPUT_LAB5) $(OUTPUT_LAB6) $(LLVM_IR) ./example.ast ./example.ll
