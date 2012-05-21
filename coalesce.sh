#!/bin/sh
#
# This script takes an xml2rfc XML file as input and replaces the 
# <?rfc include="example.xml"?> directives with the contents of 
# the example.xml file.
#

if [ 1 -ne $# ]; then
    EXEC=`basename $0`
    echo ""
    echo "Usage: $EXEC <file>"
    echo ""
    echo " where:"
    echo "       file = the file name of an xml2rfc XML file"
    echo ""
    echo " $EXEC replaces all xml2rfc include directives in file with the"
    echo " contents of the include and writes the results to standard output."
    echo ""
    exit 1
fi

FILE=$1

awk    '/rfc include/ 	{ line = $0; sub(/.*<?rfc include=\"/, "", line); sub(/\"\?>/, "", line); print line | "xargs cat" ; close("xargs cat") }
	!/rfc include/	{ print }' $FILE
