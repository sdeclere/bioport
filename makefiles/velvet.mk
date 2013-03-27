DISTNAME = velvet
VERSION = 1_2_08

URL = http://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.08.tgz
ARCHIVE = velvet_1.2.08.tgz

BUILD_SCRIPTS = $(WORKSRC)/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Makefile

include ports.mk

TAR_ARGS += --strip 1
BUILD_ENV += MAXKMERLENGTH="101"

pre-build: 
	@$(MAKE) -C $(WORKSRC)/third-party/zlib-1.2.3 distclean 
	@cd $(WORKSRC)/third-party/zlib-1.2.3  && ./configure $(CONFIGURE_ARGS) 
	@$(MAKE) -C $(WORKSRC)/third-party/zlib-1.2.3 	

post-build:
	@$(INSTALL) -C $(WORKSRC)/velvet*  $(PORTSDIR)/bin/

post-clean:
	@$(MAKE) -C $(WORKSRC)/third-party/zlib-1.2.3 clean
	@rm -fr $(WORKSRC)/obj
