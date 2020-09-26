.PHONY: install
PREFIX = /usr/local

install:
	install -d "${DESTDIR}${PREFIX}/bin"
	install -m 755 r2mod "${DESTDIR}${PREFIX}/bin/r2mod"
