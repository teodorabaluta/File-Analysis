# BALUTA TEODORA-VALENTINA 332CC
CC=gcc
CFLAGS=-Wall

TARGET=tema
LEX_SOURCE=tema.l
LEX_OUTPUT=lex.yy.c

all: build

build: $(TARGET)

$(TARGET): $(LEX_OUTPUT)
	$(CC) $(CFLAGS) -o $(TARGET) $(LEX_OUTPUT) -lfl

$(LEX_OUTPUT): $(LEX_SOURCE)
	flex $(LEX_SOURCE)

clean:
	rm -f $(TARGET) $(LEX_OUTPUT)