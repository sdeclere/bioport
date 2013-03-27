DISTNAME = samtools
VERSION = 0_1_19

URL = http://downloads.sourceforge.net/project/samtools/samtools/0.1.19/samtools-0.1.19.tar.bz2
ARCHIVE = samtools-0.1.19.tar.bz2

BUILD_SCRIPTS = $(WORKSRC)/Makefile
CLEAN_SCRIPTS = $(WORKSRC)/Makefile

#<stef>:mar. juil. 17, 2012  4:42 
# FIXEME : install lib and include for other package ... 

include ports.mk

TAR_ARGS += --strip 1


post-build:
	@$(INSTALL) -C $(WORKSRC)/misc/*.pl $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/misc/*.py $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/misc/maq2sam-short $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/misc/maq2sam-long $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/samtools  $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/bcftools/bcftools  $(PORTSDIR)/bin/
	@$(INSTALL) -C $(WORKSRC)/bcftools/vcfutils.pl  $(PORTSDIR)/bin/
