all: download-sia-ui linux win32 darwin
linux: download-linux package-linux
win32: download-win32 package-win32
darwin: download-darwin package-darwin

download-linux:
	wget https://github.com/atom/atom-shell/releases/download/v0.20.7/atom-shell-v0.20.7-linux-x64.zip
	unzip atom-shell-v0.20.7-linux-x64.zip -d linux
	rm atom-shell-v0.20.7-linux-x64.zip

package-linux:
	rm -r linux/resources/default_app
	cp -r Sia-UI linux/resources/default_app
	mv linux/atom linux/sia
	zip -r linux.zip linux
	rm -rf linux

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
	# We need to rename CFBundleDisplayName and CFBundleName
	sed -i -- 's/<string>Atom<\/string>/<string>Sia<\/string>/g' darwin/Atom.app/Contents/Info.plist
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
	rm -rf linux linux Sia-UI Sia hostdir darwin
	rm sia.wallet darwin.zip win32.zip linux.zip
