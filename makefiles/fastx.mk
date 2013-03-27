DISTNAME = fastx_toolkit
VERSION = 0_0_13_2

URL = http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit-0.0.13.2.tar.bz2
ARCHIVE = fastx_toolkit-0.0.13.2.tar.bz2

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS = $(WORKSRC)/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

include ports.mk

TAR_ARGS += --strip 1

