versions_json=/tmp/versions.json
optfolder_esr=firefox-esr
optfolder_devedition=firefox-devedition
optfolder_nightly=firefox-nightly

sudo dnf --quiet -y copr enable micl2e2/incb
sudo dnf --quiet -y install quickjs-extra

curl --location --silent "https://product-details.mozilla.org/1.0/firefox_versions.json" > ${versions_json}
cat ${versions_json} | qjsq ".FIREFOX_ESR" > ${optfolder_esr}.version
cat ${versions_json} | qjsq ".FIREFOX_DEVEDITION" > ${optfolder_devedition}.version
cat ${versions_json} | qjsq ".FIREFOX_NIGHTLY" > ${optfolder_nightly}.version
