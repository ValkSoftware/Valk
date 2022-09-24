OUT_FOLDER := output
EXE_NAME := valk

TRUE := 1

CC := clang
VFLAGS := -enable-globals -skip-unused -cc $(CC)

prod: test-dir
	VFLAGS += " -prod -cflags '-g0'"
	v $(VFLAGS) -o $(OUT_FOLDER)/$(EXE_NAME) .

test:
	v test ./tests/

debug: test-dir
	v $(VFLAGS) -o $(OUT_FOLDER)/$(EXE_NAME) -show-timings -showcc .

test-dir:
	mkdir $(OUT_FOLDER) || exit 0