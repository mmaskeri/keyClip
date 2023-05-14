#!/usr/bin/env bash

### keyClip7
### Copyright (c) 2023 Mark A. Maskeri (see LICENSE.txt)

### setup

PYFILE=`uuidgen`".py"
#cd ~/Desktop

### prepare python script, put below script in file PYFILE

echo "import zlib
import subprocess
import sys
from AppKit import NSPasteboard

# initialize pasteboard
pboard = NSPasteboard.generalPasteboard()
pbItems = pboard.pasteboardItems()
types = pbItems[0].types()
count = types.count()

# obtain NSData-form metadata for the PDF...for some reason hidden
# in TSPData.## (not always the last)
# initialize variables for scoping and error checking

fVal = -1
retrieve = None

for i in range(0,count):
  type = types[i]
  # find only instances of TSPData for checking
  fVal = type.find(\"TSPData\")
  if fVal == -1:
    continue

  # search through for XML blobs with chemdraw flag
  retrieve = pboard.dataForType_(type)
  fVal = retrieve.find(b'/XML')
  cVal = retrieve.find(b'chemdraw')

  # if chemdraw XML blob is found end iterative search
  if ((fVal != -1) and (cVal != -1)):
    rawXML = retrieve
    break

# error trap, no CDXML object found in TSPData
if (fVal == -1):
  print (\"keyClip: ChemDraw XML object not found\")
  quit()

# isolate zlib-encoded CDXML binary blob from NSPasteboard metadata
# [1:] clips off remaining newline, retains zlib header b'x(escape)x9c'
# CDXML blob should be only XML data blob on pasteboard

rawCDXML = rawXML.split(b'/XML')[1].split(b'endstream')[0].split(b'stream')[1][1:]
CDXML = zlib.decompress(rawCDXML)

# spawn pbcopy process and serve CDXML to pasteboard
copyProcess = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
copyProcess.stdin.write(CDXML)
copyProcess.stdin.close()" > $PYFILE

### execute python script

python3 $PYFILE

### cleanup

rm $PYFILE
