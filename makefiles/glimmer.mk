DISTNAME = glimmer
VERSION = 3_0_2b

URL = http://www.cbcb.umd.edu/software/glimmer/glimmer302b.tar.gz
ARCHIVE = glimmer302b.tar.gz

BUILD_SCRIPTS = $(WORKSRC)/SimpleMake/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/SimpleMake/Makefile

include ports.mk

TAR_ARGS += --strip 1
LDFLAGS += -L$(WORKSRC)/lib 

post-build:
	@$(INSTALL) -C $(WORKSRC)/bin/* $(PORTSDIR)/bin/

post-clean:
	@rm -f $(WORKSRC)/bin/*
	@rm -f $(WORKSRC)/lib/*