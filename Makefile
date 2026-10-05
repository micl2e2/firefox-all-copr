
# sources := /builddir/build/SOURCES
sources := ~/rpmbuild/SOURCES
after_tarball_inplace := after_tarball_inplace
spec_template := firefox-xyz.spec.template
launcher_template := $(after_tarball_inplace)/firefox-xyz.template
desktop_template := $(after_tarball_inplace)/firefox-xyz.desktop.template
optfolder_esr := firefox-esr
readable_esr := Firefox ESR
summary_esr := Firefox Extended Support Release
optfolder_devedition := firefox-devedition
readable_devedition := Firefox Developer Edition
summary_devedition := Firefox Developer Edition
optfolder_nightly := firefox-nightly
readable_nightly := Firefox Nightly Edition
summary_nightly := Firefox Nightly Edition
subst_launcher = '$${EXPENV_OPTFOLDER}'
subst_desktop = '$${EXPENV_LAUNCHER} $${EXPENV_READABLE_NAME}'
subst_spec = '$${EXPENV_PACKAGE_NAME} $${EXPENV_PACKAGE_VERSION} $${EXPENV_RELEASE_COUNT} $${EXPENV_PACKAGE_SUMMARY}'
# MNOTE: V_FF should be provided immediately and temporarily
tarball_esr := https://download-installer.cdn.mozilla.net/pub/firefox/releases/$${V_FF}/linux-$$(arch)/en-US/firefox-$${V_FF}.tar.xz
tarball_devedition := https://download-installer.cdn.mozilla.net/pub/devedition/releases/$${V_FF}/linux-$$(arch)/en-US/firefox-$${V_FF}.tar.xz
tarball_nightly := https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-central/firefox-$${V_FF}.en-US.linux-$$(arch).tar.xz

packages:
	sudo dnf --quiet -y install git tree gcc

srpm_esr: versions
	V_FF=$$(cat $(optfolder_esr).version); curl --location --silent $(tarball_esr) --output $(optfolder_esr)-$${V_FF}.tar.xz
	export EXPENV_OPTFOLDER=$(optfolder_esr) && cat $(launcher_template) | envsubst $(subst_launcher) > $(after_tarball_inplace)/$(optfolder_esr) # we assume launcher name is the same as opt subfolder name
	export EXPENV_LAUNCHER=$(optfolder_esr) && export EXPENV_READABLE_NAME='$(readable_esr)' && cat $(desktop_template) | envsubst $(subst_desktop) > $(after_tarball_inplace)/$(optfolder_esr).desktop
	tar --create --file $(after_tarball_inplace).tar $(after_tarball_inplace)
	mv *.tar* $(sources)
	export EXPENV_PACKAGE_NAME=$(optfolder_esr) && export EXPENV_PACKAGE_VERSION=$$(cat $(optfolder_esr).version) && export EXPENV_RELEASE_COUNT=$$(date +%y%m%d) && export EXPENV_PACKAGE_SUMMARY='$(summary_esr)' && cat $(spec_template) | envsubst $(subst_spec) > $(optfolder_esr).spec
	rpmbuild -bs $(optfolder_esr).spec

srpm_devedition: versions
	V_FF=$$(cat $(optfolder_devedition).version); curl --location --silent $(tarball_devedition) --output $(optfolder_devedition)-$${V_FF}.tar.xz
	export EXPENV_OPTFOLDER=$(optfolder_devedition) && cat $(launcher_template) | envsubst $(subst_launcher) > $(after_tarball_inplace)/$(optfolder_devedition)
	export EXPENV_LAUNCHER=$(optfolder_devedition) && export EXPENV_READABLE_NAME='$(readable_devedition)' && cat $(desktop_template) | envsubst $(subst_desktop) > $(after_tarball_inplace)/$(optfolder_devedition).desktop
	tar --create --file $(after_tarball_inplace).tar $(after_tarball_inplace)
	mv *.tar* $(sources)
	export EXPENV_PACKAGE_NAME=$(optfolder_devedition) && export EXPENV_PACKAGE_VERSION=$$(cat $(optfolder_devedition).version) && export EXPENV_RELEASE_COUNT=$$(date +%y%m%d) && export EXPENV_PACKAGE_SUMMARY='$(summary_devedition)' && cat $(spec_template) | envsubst $(subst_spec) > $(optfolder_devedition).spec
	rpmbuild -bs $(optfolder_devedition).spec

srpm_nightly: versions
	V_FF=$$(cat $(optfolder_nightly).version); curl --location --silent $(tarball_nightly) --output $(optfolder_nightly)-$${V_FF}.tar.xz
	export EXPENV_OPTFOLDER=$(optfolder_nightly) && cat $(launcher_template) | envsubst $(subst_launcher) > $(after_tarball_inplace)/$(optfolder_nightly)
	export EXPENV_LAUNCHER=$(optfolder_nightly) && export EXPENV_READABLE_NAME='$(readable_nightly)' && cat $(desktop_template) | envsubst $(subst_desktop) > $(after_tarball_inplace)/$(optfolder_nightly).desktop
	tar --create --file $(after_tarball_inplace).tar $(after_tarball_inplace)
	mv *.tar* $(sources)
	export EXPENV_PACKAGE_NAME=$(optfolder_nightly) && export EXPENV_PACKAGE_VERSION=$$(cat $(optfolder_nightly).version) && export EXPENV_RELEASE_COUNT=$$(date +%y%m%d) && export EXPENV_PACKAGE_SUMMARY='$(summary_nightly)' && cat $(spec_template) | envsubst $(subst_spec) > $(optfolder_nightly).spec
	rpmbuild -bs $(optfolder_nightly).spec

