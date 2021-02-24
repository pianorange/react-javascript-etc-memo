Manual

## Apply plugin list

1.Copy and paste the echo output to machine B(Copy to)

Please make sure you have the code command line installed. For more information,
please visit [Command Line Interface](https://code.visualstudio.com/docs/editor/command-line)

    #For Front end(React)
    code --install-extension CoenraadS.bracket-pair-colorizer-2
    code --install-extension dsznajder.es7-react-js-snippets
    code --install-extension ecmel.vscode-html-css
    code --install-extension Equinusocio.vsc-community-material-theme
    code --install-extension Equinusocio.vsc-material-theme
    code --install-extension esbenp.prettier-vscode
    code --install-extension formulahendry.auto-rename-tag
    code --install-extension janisdd.vscode-edit-csv
    code --install-extension kiteco.kite

    #Etc
    code --install-extension ms-python.python
    code --install-extension ms-toolsai.jupyter
    code --install-extension ms-vscode-remote.remote-wsl
    code --install-extension oderwat.indent-rainbow
    code --install-extension PKief.material-icon-theme
    code --install-extension pranaygp.vscode-css-peek
    code --install-extension ritwickdey.LiveServer
    code --install-extension solnurkarim.html-to-css-autocompletion

## Extract vs code extention list

Make sure you have the most current version of Visual Studio Code. If you install via a company portal, you might not have the most current version.

On machine A (Copy from)

Unix:

    code --list-extensions | xargs -L 1 echo code --install-extension

Windows (PowerShell, e. g. using Visual Studio Code's integrated Terminal):

    code --list-extensions | % { "code --install-extension $_" }
