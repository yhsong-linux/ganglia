#!/bin/bash - 
#===============================================================================
#
#          FILE:  autogen.sh
# 
#         USAGE:  ./autogen.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: gdzhang (), gdzhang@linx-info.com
#       COMPANY: linx-info
#       CREATED: 2013年07月18日 15时35分04秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

aclocal
autoheader
libtoolize -c -f 
automake --foreign --add-missing --copy
autoconf
