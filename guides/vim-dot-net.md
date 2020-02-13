##.net development in vim

##install .net core
You probably want to understand Ubuntu's repository system:
TODO: add link.. copy and paste is bonkers right now.
[Microsoft](https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1804)

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

##omnisharp
Provides code completion, ability to run unit tests, etc...
NOTE: needs vim 8 for special sugar

https://github.com/OmniSharp/omnisharp-roslyn/releases
let g:OmniSharp_server_path = '/mnt/c/Users/jcaffey/omnisharp/OmniSharp.exe'
let g:OmniSharp_translate_cygwin_wsl = 1

