#!/bin/bash

#
# https://github.com/cPLevey/magento-chmod-patch
#

# DIST_FILE: https://raw.githubusercontent.com/cPLevey/magento-chmod-patch/master/lib/Mage/Archive/Helper/File.php.dist
# PATCH_FILE: https://raw.githubusercontent.com/cPLevey/magento-chmod-patch/master/lib/Mage/Archive/Helper/File.php.patch
# PATCHED_FILE: https://raw.githubusercontent.com/cPLevey/magento-chmod-patch/master/lib/Mage/Archive/Helper/File.php.patched

FILE='lib/Mage/Archive/Helper/File.php';
if [ ! -f "$FILE" ]; then echo "FAIL - $FILE: Not found. Nothing to patch."; else
	echo "Found $FILE: Checking for patch.";
	CURRENTMODE=$(grep -Po 'chmod.*\d{4}' $FILE |awk '{print $3}');
		if [ "$CURRENTMODE" -ne "0644" ]; then echo "File is not patched. Running..."; echo " ";
			patch --verbose -N -p 0 -r - < <(curl -s https://raw.githubusercontent.com/cPLevey/magento-chmod-patch/master/lib/Mage/Archive/Helper/File.php.patch);
			echo "";
			grep -Hn chmod $FILE;
			echo "";
			echo "Done.";
		else
			echo "File may already be patched. Skipping..."
		fi
fi
