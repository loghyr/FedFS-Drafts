# Works with xml2rfc-1.32.  Might require tweaking to work with later
# versions.

XML2RFC		= xml2rfc.tcl

ADMIN_VERS=14
PROT_VERS=14

DRAFTS	= \
	draft-ietf-nfsv4-federated-fs-admin-${ADMIN_VERS}.txt \
	draft-ietf-nfsv4-federated-fs-protocol-${PROT_VERS}.txt 

AUTOGENS	= \
	admin-proto_autogen.xml \
	nsdb-proto_autogen.xml

AUTHORS		= \
	author-ellard-daniel.xml \
	author-everhart-craig.xml \
	author-lentini-james.xml \
	author-naik-manoj.xml \
	author-tewari-renu.xml

BOILERPLATE	= $(AUTHORS) glossary.xml

REQTS_SRC	= $(BOILERPLATE) reqts.xml fig-federation.aa fig-resolution.aa
NSDB_SRC	= $(BOILERPLATE) nsdb-proto.xml
ADMIN_SRC	= $(BOILERPLATE) admin-proto.xml
DNS_SRV_SRC	= dns-srv.xml

dummy:	$(DRAFTS)

draft-ietf-nfsv4-federated-fs-admin-${ADMIN_VERS}.txt: $(ADMIN_SRC)
	sed -e s/VERSIONVAR/${ADMIN_VERS}/g < admin-proto.xml > admin-proto_autogen.xml
	$(XML2RFC) admin-proto_autogen.xml $@
	@echo "Formatted $@"
	@echo ""

draft-ietf-nfsv4-federated-fs-protocol-${PROT_VERS}.txt: $(NSDB_SRC)
	sed -e s/VERSIONVAR/${PROT_VERS}/g < nsdb-proto.xml > nsdb-proto_autogen.xml
	$(XML2RFC) nsdb-proto_autogen.xml $@
	@echo "Formatted $@"
	@echo ""

clean:
	rm -f *.tmp *.date $(DRAFTS) $(AUTOGENS)

tarball:
	$(MAKE) clean
	(cd ..; tar -c -f fedfs-drafts-$(NOW).tar --exclude Drafts/CVS Drafts)
