.PHONY=all clean format reactor serve

BUILD=build
TARGET=build/main.js build/index.html
SRC_PATH=src
SRC=$(SRC_PATH)/Main.elm $(shell find src -name '*.elm' -o -name '*.js')
ELM_MAKE=elm-make
ELM_MAKE_FLAG=--warn --yes

all: $(TARGET)

$(TARGET): $(BUILD)

$(BUILD):
	mkdir $@

$(BUILD)/main.js: $(SRC)
	$(ELM_MAKE) $< --output $@ $(ELM_MAKE_FLAG)

$(BUILD)/index.html: pages/index.html
	cp $< $@

format: $(filter %.elm, $(SRC))
	elm-format-0.18 $^ --yes

clean:
	rm -rf elm-stuff/build-artifacts/
	rm -f $(TARGET)

reactor:
	elm-reactor

dependencies:
	elm-package install

serve:
	cd $(BUILD) && python -m SimpleHTTPServer 3000
