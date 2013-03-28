#
# Top level makefile for bioports 
# run make for building the whole ports 
#

# quiet make 
# .SILENT:

MAKE= make
PORTS= libgtextutils bwa fastx samtools tagdust velvet quast minia sickle fastqc glimmer # Gasst 

DONADA = @echo "[$@] complete.  Finished rules: $+"

# Main target 
all: init build

# init port fs 
init: 
	@$(MAKE) -f ports.mk init-port 

# Main target actually compile all
PORTS_TARGETS = $(addprefix build-,$(PORTS))
build: $(PORTS_TARGETS) 
	$(DONADA)

build-%: 
	@echo " ==> Build port:  $*"
	@$(MAKE) -f $*.mk 
#

# Pureg targets 
PURGE_TARGETS = $(addprefix purge-,$(PORTS))
purge: $(PURGE_TARGETS)
	$(DONADA)
	
purge-%: 
	@echo " ==> Purging port $*"
	@$(MAKE) -f $*.mk purge 
#

# Clean targets 
CLEAN_TARGETS = $(addprefix clean-,$(PORTS))
clean: $(CLEAN_TARGETS)
	$(DONADA)
	
clean-%: 
	@echo " ==> Cleaning port $*"
	@$(MAKE) -f $*.mk clean
#

## DEBUG
print-%:
	@echo "[ $* ] : $($*)"