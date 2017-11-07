# blackhole
Blackhole is a bash script for MacOSX that allows to quickly set up a TOR-proxy and redirect all your computer traffic through the TOR Network.  

## How to use it ? 
The usage is easy: 
`git clone` this repo in your desired path.  
`cd` inside the git folder
`chmod +x blackhole.sh`
`. ./blackhole.sh`

Once the software starts it will check if you have the necessary dependecies installed (Tor and homebrew), if not, it will install them.
Then you will be prompt to select one of your network interfaces and your root psw, that is used to set-up the proxy in MacOSX system preferences.
Once the tor network finished the bootstrapping phase you will be ready to go ! 

try `https://check.torproject.org/`

TO exit correctly the script use Ctrl-C for three times ! 
This will close the tor service cleaning up the used processes and will restore your no-proxy settings in Macosx.


I'm tring to port this script also in Linux, everyone can help and contribute :D 
Thanks. 
