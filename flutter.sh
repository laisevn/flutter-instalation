#!/bin/bash
echo "Olá, este script roda comandos para configurar o Flutter."

echo "Antes de avançar, certifique que tenha intalado o Xcode. Você ja instalou? Digite uma das opções e aperte ENTER : (s--sim ou n--nāo)"

read resposta

if test "$resposta" == "n";then
	 open -a App\ Store
else 
	echo "Você aceita proceguir com esta instalaçāo? Digite uma das opções e aperte ENTER : (s --sim ou n --nāo)"

	read answer 

	if  test "$answer" == "s"; then
		echo "Começando..."
		
		echo "Isto vai levar um tempo. Tome um café..."

		FILE=~/Documents/flutter_macos.zip

		if [ -f "$FILE" ]; then
		    unzip ~/Documents/flutter_macos.zip 
		else 
			curl https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.17.1-stable.zip -o ~/Documents/flutter_macos.zip 
			unzip ~/Documents/flutter_macos.zip 
		fi

		sudo sh -c 'echo "export PATH=/Users/$USER/flutter/bin:$PATH" >> ~/.bash_profile'
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

		echo "--------Instalando Android Studio"
		brew cask install android-studio
		echo "OK"


		echo "--------Licensa Android Studio"
		flutter doctor --android-licenses
		echo "OK"

		echo "--------Configurando Xcode"
		sudo xcode-select --switch
		sudo xcodebuild -runFirstLaunch
		sudo gem install cocoapods
		sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
        sudo xcodebuild -runFirstLaunch
		echo "OK"

		echo "--------Instalando VisualCode e Flutter Plugin"
		brew cask install visual-studio-code
		code --install-extension Dart-Code.flutter
		echo "OK"

		flutter create your_first_app
		cd your_first_app
  		VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*

	else
	  echo "Tudo bem, até mais! Esta janela será fechada."
	fi
fi 








