.PHONY: all clean

CA65 := ca65
LD65 := ld65
MKDIR := mkdir

CFG := common.cfg
INCS := $(wildcard *.inc)
SRCS := $(wildcard *.s65)

OUT_DIR := build
TARGET := $(patsubst %.s65,$(OUT_DIR)/%.nes,$(SRCS))

all: $(TARGET)

$(OUT_DIR)/%.nes: $(OUT_DIR)/%.o $(CFG) | $(OUT_DIR)/.
	$(LD65) --config $(CFG) -o $@ $<

$(OUT_DIR)/%.o: %.s65 $(INCS) | $(OUT_DIR)/.
	$(CA65) -o $@ $<

$(OUT_DIR)/.:
	$(MKDIR) -p $@

clean:
	-$(RM) -r $(OUT_DIR)
