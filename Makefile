.PHONY: install bin completions flatpak

DESTDIR = /usr

install: bin completions

bin:
	install -D -m 755 r2mod "${DESTDIR}${PREFIX}/bin/r2mod"

completions:
	install -D -m 644 "completions/bash/r2mod.sh" "${DESTDIR}${PREFIX}/share/bash-completion/completions/r2mod"
	install -D -m 644 "completions/zsh/_r2mod" "${DESTDIR}${PREFIX}/share/zsh/site-functions/_r2mod"

flatpak:
	install -D -m 755 r2mod "${FLATPAK_DEST}/bin/r2mod"
	install -D -m 644 flatpak/logo.svg ${FLATPAK_DEST}/share/icons/hicolor/scalable/apps/${FLATPAK_ID}.svg
	install -D -m 644 flatpak/${FLATPAK_ID}.metainfo.xml ${FLATPAK_DEST}/share/metainfo/${FLATPAK_ID}.metainfo.xml
	install -D -m 644 completions/zsh/_r2mod ${FLATPAK_DEST}/data/completions/zsh/_r2mod
	install -D -m 644 completions/bash/r2mod.sh ${FLATPAK_DEST}/data/completions/bash/r2mod.sh
