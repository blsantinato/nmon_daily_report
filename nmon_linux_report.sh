#!/bin/bash
###################################################################################
# Script para rodar nmon e rotacionar logs em servidores linux                    #
# Esse report gera diariamente um arquivo .nmon para analise de performance e/ou  #
# possiveis eventuais problemas de capacity.                                      #
# v1.0                                                                            #
###################################################################################
NMON=/usr/bin/nmon
NMONLOG=/home/logs/nmon

if [ ! -d $NMONLOG ]; then
  mkdir -p $NMONLOG
fi

if [ ! -z $NMONPID ]; then
  kill -USR2 $NMONPID
fi

# Start NMON
NMONPID=`$NMON -fT -s60 -c1440 -m $NMONLOG -p`

# Compacta logs anteriores a 5 dias
find $NMONLOG -name "*.nmon" -ctime +5 -exec gzip -9 {} \;

# Remove logs anteriores a 90 dias
find $NMONLOG -name "*.nmon.gz" -ctime -90 -exec rm -f {} \;