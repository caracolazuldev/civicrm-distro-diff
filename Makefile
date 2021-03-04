include mdo-config.mk


release: ${RELEASE_ARCH}
	test -d $@ || mkdir -p $@
	tar xzf ${RELEASE_ARCH} -C $@ civicrm

site : ${SITE_ARCH}
	test -d $@ || mkdir -p $@
	tar xzf ${SITE_ARCH}  --xform='s#${CIVI_ROOT}#civicrm/#' -C $@ ${CIVI_ROOT}

clean:
	test ! -d release || rm -rf release
	test ! -d site || rm -rf site