# Redistribution and/or use, with or without modification, is
# permitted.  This software is without warranty of any kind.  The
# author(s) shall not be liable in the event that use of the
# software causes damage.


# Top level makefile for pavane ports 
#  <stef> 



# quiet make 
# .SILENT:

MAKE= make
PORTS= libgtextutils bwa fastx samtools tagdust velvet quast minia 

DONADA = @echo "[$@] complete.  Finished rules: $+"

# Main target 
all: build


# Main target actually compile all
PORTS_TARGETS = $(addprefix build-,$(PORTS))

build: $(PORTS_TARGETS) 
	$(DONADA)

build-%: 
	@echo " ==> Making ports $*"
	@$(MAKE) -f $*.mk
	 
clean: 
	@for m in *.mk; do \
	echo "==> cleaning $$m"; \
	($(MAKE) -f $$m clean); done 

## DEBUG
print-%:
	@echo "[ $* ] : $($*)"