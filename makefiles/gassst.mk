DISTNAME = gassst
VERSION = 1_28

URL = http://www.irisa.fr/symbiose/projects/gassst/Gassst_v1.28.tar.gz
ARCHIVE = Gassst_v1.28.tar.gz

BUILD_SCRIPTS = $(WORKSRC)/Gassst_v1.28/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Gassst_v1.28/Makefile

include ports.mk

TAR_ARGS += --strip 1
