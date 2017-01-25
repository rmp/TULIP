MAJOR          ?= 0
MINOR          ?= 4
SUB            ?= 0
PATCH          ?= 1

setup:
	perl Build.PL

test: setup
	TEST_AUTHOR=1 ./Build test

cover: setup
	./Build testcover

manifest: setup
	touch MANIFEST
	rm MANIFEST
	./Build manifest

versions:
	find lib bin t -type f -exec perl -i -pe 's/VERSION\s+=\s+q[[\d.]+]/VERSION = q[$(MAJOR).$(MINOR).$(SUB)]/g' {} \;

deb: test
	touch tmp
	rm -rf tmp
	mkdir -p tmp/DEBIAN tmp/usr/lib/perl5
	cp -pR bin tmp/usr/
	cp debian/control.tmpl tmp/DEBIAN/control
	$(SEDI) "s/MAJOR/$(MAJOR)/g"       tmp/DEBIAN/control
	$(SEDI) "s/MINOR/$(MINOR)/g"       tmp/DEBIAN/control
	$(SEDI) "s/PATCH/$(PATCH)/g"       tmp/DEBIAN/control
	$(SEDI) "s/SUB/$(SUB)/g"           tmp/DEBIAN/control
	chmod -R 0755 tmp/DEBIAN
	chmod -R go-w tmp
	(cd tmp; fakeroot dpkg -b . ../tulip-assembler-$(MAJOR).$(MINOR).$(SUB)-$(PATCH).deb)
