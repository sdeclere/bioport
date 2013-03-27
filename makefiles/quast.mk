DISTNAME = quast
VERSION = 2_1

URL = http://downloads.sourceforge.net/project/quast/quast-2.1.tar.gz
ARCHIVE = quast-2.1.tar.gz


include ports.mk

TAR_ARGS += --strip 1

post-install: 
	@$(MKDIR) $(PORTSDIR)/opt/
	@cp -a $(WORKSRC) $(PORTSDIR)/opt/