#!/bin/bash

NAME=$1;
MAC=$(virsh domiflist ${NAME} | sed '1d;2d' | awk '{print $5}');
UUID=$(virsh domuuid ${NAME});

echo $NAME,$MAC,$UUID
