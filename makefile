LUA_VERSION =       5.1
TARGET =            qrencode.so
PREFIX =            /usr/
CFLAGS =            -O3 -Wall -fPIC
LDFLAGS =           -shared -fPIC -lqrencode -lpng
LUA_INCLUDE_DIR ?=  $(PREFIX)/include
LUA_CMODULE_DIR ?=  $(PREFIX)/lib/lua/$(LUA_VERSION)
LUA_MODULE_DIR ?=   $(PREFIX)/share/lua/$(LUA_VERSION)
LUA_BIN_DIR ?=      $(PREFIX)/bin

EXECPERM =          755

OBJS =              qrencode.o

NAME=lua-qrencode
VERSION=0.1.0


all: ${TARGET}

${OBJS}: qrencode.c
	$(CC) -c $(CFLAGS) -o $@ $<

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $(CJSON_LDFLAGS) -o $@ $(OBJS)

install: $(TARGET)
	mkdir -p $(DESTDIR)$(LUA_CMODULE_DIR)
	rm -f $(DESTDIR)$(LUA_CMODULE_DIR)/$(TARGET)
	cp $(TARGET) $(DESTDIR)$(LUA_CMODULE_DIR)
	chmod $(EXECPERM) $(DESTDIR)$(LUA_CMODULE_DIR)/$(TARGET)

clean:
	rm -f *.o $(TARGET)


dist:
	mkdir -p ${NAME}-${VERSION}
	cp -r qrencode.c ${NAME}.spec makefile ${NAME}-${VERSION}/
	tar -czf ${NAME}-${VERSION}.tgz ${NAME}-${VERSION}
	rpmbuild -tb ${NAME}-${VERSION}.tgz
	rm -rf ${NAME}-${VERSION} ${NAME}-${VERSION}.tgz
