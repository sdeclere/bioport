DISTNAME = libgtextutils
VERSION = 0_6_1

URL = http://hannonlab.cshl.edu/fastx_toolkit/libgtextutils-0.6.1.tar.bz2
ARCHIVE = libgtextutils-0.6.1.tar.bz2

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

include ports.mk

TAR_ARGS += --strip 1

