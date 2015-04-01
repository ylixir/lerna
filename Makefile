# for fish shell
VC=valac
VFLAGS=--pkg gtk+-3.0 --pkg webkit2gtk-4.0 --pkg gee-1.0
VSOURCES=main.vala window.vala page.vala tabstrip.vala button.vala tab.vala
VOBJECTS=$(VSOURCES:%.vala=%.c) $(VSOURCES:%.vala=%.o)

TARGET=lerna

all: $(SOURCES) $(TARGET)

$(TARGET): $(SOURCES)
	$(VC) $(VFLAGS) $(VSOURCES) -o $(TARGET)

clean:
	rm -f $(VOBJECTS) $(TARGET)
