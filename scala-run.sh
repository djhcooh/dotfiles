#!/bin/sh
if [ $# -ne 1 ]; then
	echo "the number of arguments is invalid"
	exit 1
fi

scala ren.kujoka.$1.$1

exit 0
