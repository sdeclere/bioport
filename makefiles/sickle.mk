DISTNAME = sickle
VERSION = 1_2

URL = https://github.com/najoshi/sickle/archive/master.zip
ARCHIVE = master.zip

BUILD_SCRIPTS = $(WORKSRC)/sickle-master/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/sickle-master/Makefile

include ports.mk

WGET_OPTS += --no-check-certificate
LDFLAGS += -lz

post-build: 
	@$(INSTALL) -C $(WORKSRC)/sickle-master/sickle $(PORTSDIR)/bin/
