.PHONY: install
PREFIX = /usr

install:
	install -d "${DESTDIR}${PREFIX}/bin"
	install -m 755 r2mod "${DESTDIR}${PREFIX}/bin/r2mod"
	install -d "${DESTDIR}${PREFIX}/share/bash-completion/completions"
	install -m 644 "completions/bash/r2mod.sh" "${DESTDIR}${PREFIX}/share/bash-completion/completions/r2mod"
	install -d "${DESTDIR}${PREFIX}/share/zsh/site-functions/"
	install -m 644 "completions/zsh/_r2mod" "${DESTDIR}${PREFIX}/share/zsh/site-functions/_r2mod"
