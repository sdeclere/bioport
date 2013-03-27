DISTNAME = tagdust
VERSION = 1_12

URL = http://genome.gsc.riken.jp/osc/english/software/src/tagdust.tgz
ARCHIVE = tagdust.tgz

BUILD_SCRIPTS = $(WORKSRC)/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Makefile

include ports.mk

TAR_ARGS += --strip 1

post-build:
	@$(INSTALL) -C $(WORKSRC)/tagdust $(PORTSDIR)/bin/
