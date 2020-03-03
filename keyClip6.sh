#!/usr/bin/env bash

### Copyright (c) 2019 Mark A. Maskeri (see LICENSE.txt)

### setup

PYFILE=`uuidgen`".py"
cd ~/Desktop

### prepare python script, put below script in file PYFILE

echo "import zlib
import subprocess
import sys
from AppKit import NSPasteboard

# initialize pasteboard
pboard = NSPasteboard.generalPasteboard()
pbItems = NSPasteboard.generalPasteboard().pasteboardItems()
types = pbItems[0].types()
count = types.count()

# obtain NSData-form metadata for the PDF...for some reason hidden
# in TSPData.## (not always the last)
# and convert to string form for further processing

# initialize variables for scoping and error checking
fVal = -1
retrieve = None

for i in range(0,count):
  type = unicode(types[i])

  # find only instances of TSPData for checking
  fVal = type.find(\"TSPData\")
  if fVal == -1:
    continue

  # search through for XML blobs
  retrieve = str(pboard.dataForType_(type))
  fVal = retrieve.find(\"/XML\")
  cVal = retrieve.find(\"chemdraw\")

  # matched TSPData and found XML blob therein
  if (fVal != -1) and (cVal != -1):
    rawSTR = retrieve
    break

# error trap
if fVal == -1:
  print \"keyClip: ChemDraw XML object not found\"
  quit()

# isolate zlib-encoded CDXML binary blob from NSPasteboard metadata
# [1:] clips off remaining newline, retains zlib header b'x(escape)x9c'
# CDXML blob should be only XML data blob on pasteboard
# if Adobe changes PDF file format, can adjust using cambridgesoft tag
CDXML = zlib.decompress(rawSTR.split(\"/XML\")[1].split(\"endstream\")[0].split(\"stream\")[1][1:])

# spawn pbcopy process and paste CDXML to clipboard
copyProcess = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
copyProcess.stdin.write(CDXML)
copyProcess.stdin.close()" > $PYFILE

### execute python script

python $PYFILE

### cleanup

rm $PYFILE
