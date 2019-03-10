#!/bin/bash

echo "Installing patches..."
cd /usr/circle/patch

for patch in *.patch; do
	echo "Installing $patch..."

	cd /usr/circle/patch
	if [ -a "$patch.sh" ]; then
		./$patch.sh
	fi

	cp $patch /usr/circle/src/$patch
	cd /usr/circle/src
	patch --silent --batch < $patch
done
