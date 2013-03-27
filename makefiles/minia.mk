DISTNAME = minia
VERSION = 1_4961

URL = http://minia.genouest.org/files/minia-1.4961.tar.gz
ARCHIVE = minia-1.4961.tar.gz

BUILD_SCRIPTS = $(WORKSRC)/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Makefile
CC = g++ 

include ports.mk

TAR_ARGS += --strip 1

post-build:
	@$(INSTALL) -C $(WORKSRC)/minia $(PORTSDIR)/bin/