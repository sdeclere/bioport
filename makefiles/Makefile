# Redistribution and/or use, with or without modification, is
# permitted.  This software is without warranty of any kind.  The
# author(s) shall not be liable in the event that use of the
# software causes damage.


# Top level makefile for pavane ports 
#  <stef> 



# quiet make 
# .SILENT:

MAKE= make
PORTS= bowtie bwa calDepth fastq fastx maq samtools tagdust velvet fast_q_uniq

all: $(PORTS)

# libs 
google-sparsehash:
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

libgtextutils:
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

# softwares 
abyss: google-sparsehash
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

bwa: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

maq: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk


bowtie: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

calDepth: samtools
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

fastq: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

fastx: libgtextutils
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

samtools: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

tagdust: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

velvet: 
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

fast_q_uniq:
	@echo " ==> Running make for $@"
	@$(MAKE) -f $@.mk

clean: 
	@for m in *.mk; do \
	echo "==> cleaning $$m"; \
	($(MAKE) -f $$m clean); done 

