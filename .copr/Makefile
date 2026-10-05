# # # # #
# ONLY FOR COPR ENVIRONMENT
# # # # #
# make -f .copr/Makefile srpm outdir="<outdir>" spec="<spec_path>"
# # # # #

sources := /builddir/build/SOURCES

packages:
	dnf --quiet -y install git tree gcc gettext-envsubst

create_source_rpm:
	[[ $(spec) =~     esr ]] && make -f Makefile srpm_esr && echo srpm_esr
	[[ $(spec) =~     dev ]] && make -f Makefile srpm_devedition && echo srpm_devedition
	[[ $(spec) =~ nightly ]] && make -f Makefile srpm_nightly && echo srpm_nightly

all_source_rpm_to_workdir:
	tree ~/build
	mv ~/build/SRPMS/*.src.rpm $(outdir)

srpm: packages create_source_rpm all_source_rpm_to_workdir
	echo SRPM done

