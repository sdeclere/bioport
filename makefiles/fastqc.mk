DISTNAME = fastqc
VERSION = 0_10_1

URL = http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.10.1.zip
ARCHIVE = fastqc_v0.10.1.zip


include ports.mk


post-install: 
	@cp -a $(WORKSRC) $(PORTSDIR)/opt/