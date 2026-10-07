# # # # #
# ONLY FOR COPR ENVIRONMENT
# # # # #
# make -f .copr/Makefile srpm outdir="<outdir>" spec="<spec_path>"
# # # # #

copr_sources := /builddir/build/SOURCES

packages:
	dnf --quiet -y install git tree gcc gettext-envsubst

create_source_rpm:
	[[ $(spec) =~     esr ]] && make -f Makefile srpm_esr rpmbuild_sources=$(copr_sources) && echo srpm_esr || echo skip
	[[ $(spec) =~     dev ]] && make -f Makefile srpm_devedition rpmbuild_sources=$(copr_sources) && echo srpm_devedition || echo skip
	[[ $(spec) =~ nightly ]] && make -f Makefile srpm_nightly rpmbuild_sources=$(copr_sources) && echo srpm_nightly || echo skip

all_source_rpm_to_workdir:
	tree ~/build
	mv ~/build/SRPMS/*.src.rpm $(outdir)

srpm: packages create_source_rpm all_source_rpm_to_workdir
	echo SRPM done

