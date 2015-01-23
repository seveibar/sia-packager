import re
import subprocess

# We need to rename CFBundleDisplayName and CFBundleName
#
infolist = open('darwin/Atom.app/Contents/Info.plist')
content = infolist.read()
content = content.replace("<string>Atom</string>", "<string>Sia</string>")
infolist.close()
open('darwin/Atom.app/Contents/Info.plist','w').write(content)
