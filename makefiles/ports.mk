# 
# Makefile rules for bioports.
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Quiet make 
#.SILENT:

MACHINE = $(shell sh -c 'uname -s 2>/dev/null || echo not')
include $(MACHINE)-defines.mk

# GLOBALS
DOWNLOADDIR ?= $(shell dirname $$PWD)/tarballs
SRCDIR ?= $(shell dirname $$PWD)/playground
WORKSRC ?= $(SRCDIR)/$(DISTNAME)_$(VERSION)
PORTSDIR ?= $(shell dirname $$PWD)/ports/$(MACHINE)
CONFIGURE_ARGS = --prefix=$(PORTSDIR)
PARALLELMFLAGS = -j4

# PORTS TREE
prefix ?= $(PORTSDIR)
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
sbindir = $(exec_prefix)/sbin
libexecdir = $(exec_prefix)/libexec
datadir = $(prefix)/share
sysconfdir = $(prefix)/etc
sharedstatedir = $(prefix)/share
localstatedir = $(prefix)/var
libdir = $(exec_prefix)/lib
infodir = $(prefix)/info
lispdir = $(prefix)/share/emacs/site-lisp
includedir = $(prefix)/include
mandir = $(prefix)/man
docdir = $(prefix)/share/doc
optdir = $(prefix)/opt

INSTALL_DIRS = $(SRCDIR) $(DOWNLOADDIR) $(prefix) $(exec_prefix) $(bindir) $(sbindir) $(libexecdir) $(datadir) $(sysconfdir) $(sharedstatedir) $(localstatedir) $(libdir) $(infodir) $(lispdir) $(includedir) $(optdir) $(foreach NUM,1 2 3 4 5 6 7 8, $(mandir)/man$(NUM))

# Put these variables in the environment during the build stage
# Allow us to link to libraries we installed
CPPFLAGS += -I$(includedir)
CFLAGS += -L$(libdir)
LDFLAGS += -L$(libdir) 
STAGE_EXPORTS = CPPFLAGS CFLAGS LDFLAGS FFLAGS CC CXX AR
BUILD_ENV += $(foreach TTT,$(STAGE_EXPORTS),$(TTT)="$($(TTT))")

# This is for foo-config chaos
PKG_CONFIG_PATH=$(libdir)/pkgconfig/
TAR_ARGS = --no-same-owner

# Main TARGET
DONADA = @echo "[$@] complete.  Finished rules: $+"

all: build
	@$(DONADA)

# Target for creation of the port's fs tree 
init-port:
	@for d in $(INSTALL_DIRS) ; do echo "+ creating : $$d" && install -d $$d ; done

# "Fallback" rules for pre/post targets
pre-%:
	@true

post-%:
	@true

# Main target actually compile the sources.
BUILD_TARGETS = $(addprefix build-,$(BUILD_SCRIPTS))

build: fetch extract configure pre-build $(BUILD_TARGETS) post-build install
	$(DONADA)
	
	
FETCH_TARGETS =  $(addprefix $(DOWNLOADDIR)/,$(ARCHIVE))

# Fetch software 
fetch:  pre-fetch $(FETCH_TARGETS) post-fetch
		$(DONADA)

# Extract archives in pool 
TGZ_TARGETS = $(addprefix tar-gz-extract-, $(filter %.tgz,$(ARCHIVE)))
TARGZ_TARGETS = $(addprefix tar-gz-extract-, $(filter %.tar.gz,$(ARCHIVE)))
TAR_TARGETS = $(addprefix tar-extract-, $(filter %.tar,$(ARCHIVE)))
TARBZ_TARGETS = $(addprefix tar-bz-extract-, $(filter %.tar.bz,$(ARCHIVE)))
TARBZ_TARGETS = $(addprefix tar-bz-extract-, $(filter %.tar.bz2,$(ARCHIVE)))

extract: pre-tar $(TGZ_TARGETS) $(TARGZ_TARGETS) $(TAR_TARGETS) $(TARBZ_TARGETS) post-tar
		$(DONADA)
		
# Runs GNU configure if needed
CONFIGURE_TARGETS = $(addprefix configure-,$(CONFIGURE_SCRIPTS))

configure: pre-configure $(CONFIGURE_TARGETS) post-configure
	$(DONADA)

# Install binaries 
INSTALL_TARGETS = $(addprefix install-,$(INSTALL_SCRIPTS)) 

install: pre-install $(INSTALL_TARGETS) post-install
	$(DONADA)

# Clean distribution 
CLEAN_TARGETS = $(addprefix clean-,$(CLEAN_SCRIPTS)) 

clean: pre-clean $(CLEAN_TARGETS) post-clean 
	$(DONADA)

# remove archvie 
PURGE_TARGETS =  $(addprefix purge-$(DOWNLOADDIR)/,$(ARCHIVE))

purge: $(PURGE_TARGETS) 
	$(DONADA)
	
##  -- RULES -- 

# rule to extract uncompressed 
tar-extract-%:
	@echo " ==> Extracting $(DOWNLOADDIR)/$*"
	@$(MKDIR) $(WORKSRC)
	@$(TAR) $(TAR_ARGS) -xf $(DOWNLOADDIR)/$* -C $(WORKSRC)

# rule to extract files with tar xzf
tar-gz-extract-%:
	@echo " ==> Extracting $(DOWNLOADDIR)/$*"
	@$(MKDIR) $(WORKSRC)
	@gzip -dc $(DOWNLOADDIR)/$* | $(TAR) $(TAR_ARGS) -xf - -C $(WORKSRC)

# rule to extract files with tar and bzip
tar-bz-extract-%:
	@echo " ==> Extracting $(DOWNLOADDIR)/$*"
	@$(MKDIR) $(WORKSRC)
	@bzip2 -dc $(DOWNLOADDIR)/$* | $(TAR) $(TAR_ARGS) -xf - -C $(WORKSRC)

# download software only support http 
$(DOWNLOADDIR)/%:
	@if test -f $(DOWNLOADDIR)/$* ; then true ; else \
		echo " ==> Grabbing $@" ; \
		wget $(WGET_OPTS) -T 30 -c -P $(DOWNLOADDIR) $(URL) ; \
	fi

# configure a package that has an autoconf-style configure script.
configure-%/configure: 
	@echo " ==> Running configure in $*"
	@cd $* && PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)" ./configure $(CONFIGURE_ARGS)

# build from a standard gnu-style makefile's default rule.
build-%/Makefile:
	@echo " ==> Running make in $*"
	$(MAKE) -C $* $(BUILD_ENV) $(PARALLELMFLAGS)

# just run make install and hope for the best.
install-%/Makefile:
	@echo " ==> Running make install in $*"
	@$(MAKE) -C $* install

clean-%/Makefile:
	@echo " ==> Clean $*"
	@$(MAKE) -C $* clean 

purge-$(DOWNLOADDIR)/%:
	@rm -fr $(DOWNLOADDIR)/$*
	@rm -fr $(WORKSRC)
	
## DEBUG
print-%:
	@echo "[ $* ] : $($*)"

# Previous rules are non-parallelizable
.NOTPARALLEL:
