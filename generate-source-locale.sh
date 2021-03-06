#!/bin/bash

# Constants
GETTEXT_DOMAIN="syncthing-gtk"
MESSAGES_PO="messages.po"
SRCLOCALE="en"

# Generate messages.po
[ -e ${MESSAGES_PO} ] && rm ${MESSAGES_PO}
xgettext -e syncthing_gtk/*.py *.glade

filename=${SRCLOCALE}/LC_MESSAGES/${GETTEXT_DOMAIN}.po
mo=${SRCLOCALE}/LC_MESSAGES/${GETTEXT_DOMAIN}.mo
mkdir -p ${SRCLOCALE}/LC_MESSAGES
if [ -e ${filename} ] ; then
	# Merge new strings to existing po file
	msgmerge --update ${filename} ${MESSAGES_PO} || exit 1
	echo "Merged" ${filename}
	msgfmt ${filename} -o ${mo}
else
	# Copy new po file
	cp ${MESSAGES_PO} ${filename} || exit 1
	echo "Created" ${filename}
fi
