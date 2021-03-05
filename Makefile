include mdo-config.mk

diff := diff -ur release/ site/
distinct-files := $(diff) --brief | grep -v : | cut -d ' ' -f 3,5

report: clean diff unique.list

list-files:
	@$(distinct-files) | cut -d ' ' -f 2

diff: release site
	$(diff) | awk -f split-diffs.awk 

unique.list:
	$(diff) --brief | grep -v distin | tee $@
.PHONY: unique.list

release: ${RELEASE_ARCH}
	test -d $@ || mkdir -p $@
	tar xzf ${RELEASE_ARCH} -C $@ civicrm

site : ${SITE_ARCH}
	test -d $@ || mkdir -p $@
	tar xzf ${SITE_ARCH}  --xform='s#${CIVI_ROOT}#civicrm/#' -C $@ ${CIVI_ROOT}

clean:
	test ! -d patches || rm -rf patches
	test ! -d release || rm -rf release
	test ! -d site || rm -rf site