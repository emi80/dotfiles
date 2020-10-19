#!/bin/env bash
set -u
set -u
SRC=/home/emilio
DST=${1-/media/emilio/TOSHIBA_LINUX/duplicity}

duplicity --exclude-filelist ~/.duplicity.list \
          --ignore-errors \
          --progress \
          $SRC \
          file://$DST
