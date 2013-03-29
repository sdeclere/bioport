DISTNAME = quip
VERSION = 1_1_6

URL = http://homes.cs.washington.edu/%7Edcjones/quip/quip-1.1.6.tar.gz
ARCHIVE = quip-1.1.6.tar.gz

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

include ports.mk

TAR_ARGS += --strip 1

