.PHONY: all clean format reactor serve

SRC_PATH := src
STATIC_PATH := static

ELM_MAKE := elm-make
ELM_MAKE_FLAG := --warn --yes

BUILD := build
TARGET_JS := $(BUILD)/main.js
TARGET := $(TARGET_JS) $(BUILD)/index.html
SRC_JS := $(shell find $(SRC_PATH) -name '*.elm')
SRC_ELM := $(shell find $(SRC_PATH) -name '*.js')
SRC := $(SRC_PATH)/Main.elm $(SRC_JS) $(SRC_ELM)

all: $(TARGET)

$(TARGET): $(BUILD)

$(BUILD):
	mkdir $@

$(BUILD)/main.js: $(SRC) $(BUILD)
	$(ELM_MAKE) $< --output $@ $(ELM_MAKE_FLAG)

$(BUILD)/%.html: %.html $(BUILD)
	cp $< $@

format: $(filter %.elm, $(SRC))
	elm-format-0.18 $^ --yes

clean:
	rm -rf elm-stuff/build-artifacts/
	rm -f $(TARGET)
	rm -rf $(BUILD)

live: $(SRC)
	elm-live \
		--output=$(STATIC_PATH)/main.js $< \
		--pushstate \
		--open \
		--debug \
		--dir=$(STATIC_PATH)
