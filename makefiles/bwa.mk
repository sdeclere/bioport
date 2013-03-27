DISTNAME = bwa
VERSION = 0_7_3a

URL = http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.3a.tar.bz2
ARCHIVE = bwa-0.7.3a.tar.bz2

BUILD_SCRIPTS = $(WORKSRC)/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Makefile

include ports.mk

TAR_ARGS += --strip 1

post-build:
	@$(INSTALL) -C $(WORKSRC)/*.pl $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/bwa  $(PORTSDIR)/bin/


