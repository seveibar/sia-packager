all: download-sia-ui linux32 linux64 win32 darwin
linux32: download-linux32 package-linux32
linux64: download-linux64 package-linux64
win32: download-win32 package-win32
darwin: download-darwin package-darwin

download-linux32:
	wget https://github.com/atom/atom-shell/releases/download/v0.20.7/atom-shell-v0.20.7-linux-ia32.zip
	unzip atom-shell-v0.20.7-linux-ia32.zip -d linux32
	rm atom-shell-v0.20.7-linux-ia32.zip

package-linux32:
	rm -r linux32/resources/default_app
	cp -r Sia-UI linux32/resources/default_app
	mv linux32/atom linux32/sia
	zip -r linux32.zip linux32
	rm -rf linux32

download-linux64:
	wget https://github.com/atom/atom-shell/releases/download/v0.20.7/atom-shell-v0.20.7-linux-x64.zip
	unzip atom-shell-v0.20.7-linux-x64.zip -d linux64
	rm atom-shell-v0.20.7-linux-x64.zip

package-linux64:
	rm -r linux64/resources/default_app
	cp -r Sia-UI linux64/resources/default_app
	mv linux64/atom linux64/sia
	zip -r linux64.zip linux64
	rm -rf linux64

download-win32:
	wget https://github.com/atom/atom-shell/releases/download/v0.20.7/atom-shell-v0.20.7-win32-ia32.zip
	unzip atom-shell-v0.20.7-win32-ia32.zip -d win32
	rm atom-shell-v0.20.7-win32-ia32.zip

package-win32:
	rm -r win32/resources/default_app
	cp -r Sia-UI win32/resources/default_app
	# We can't rename the binary on windows
	# mv win32/atom win32/sia
	zip -r win32.zip win32
	rm -rf win32

download-darwin:
	wget https://github.com/atom/atom-shell/releases/download/v0.20.7/atom-shell-v0.20.7-darwin-x64.zip
	unzip atom-shell-v0.20.7-darwin-x64.zip -d darwin
	rm atom-shell-v0.20.7-darwin-x64.zip

package-darwin:
	rm -r darwin/Atom.app/Contents/Resources/default_app
	cp -r Sia-UI darwin/Atom.app/Contents/Resources/default_app
	python darwin-configure.py
	mv darwin/Atom.app/Contents/MacOS/Atom darwin/Atom.app/Contents/MacOS/Sia
	zip -r darwin.zip darwin
	rm -rf darwin

download-sia:
	git clone git@github.com:NebulousLabs/Sia.git
	cd Sia && make xc

download-sia-ui:
	git clone git@github.com:NebulousLabs/Sia-UI.git
	cd Sia-UI && make
clean:
	rm -rf linux32 linux64 Sia-UI Sia hostdir darwin
	rm sia.wallet darwin.zip win32.zip linux32.zip linux64.zip
