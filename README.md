NoShutdown is a PoC showing how simple could be to evade the recent "iShutdown" detection mechanisms from Kaspersky Labs.

[Read here Kaspersky's blogpost](https://securelist.com/shutdown-log-lightweight-ios-malware-detection-method/111734/)

Basically it consists in letting the main thread of a binary listen to ```com.apple.springboard.deviceWillShutDown``` Darwin notification and kindly close itself with 'exit(0)' inside the callback function.

I only tested with an old checkra1n-able iPhone 7 with iOS 14.8.

To have a try with different iPhones/iOS version:

1. Build the binaries with ```build.sh```
2. scp them inside, for example, '/private/var/db/com.apple.xpc.roleaccountd.staging'
3. Execute the launcher from an ssh shell
4. Reboot the phone

'shutdown.log' file should not contain any trace of 'no_shutdown' process.  

On the other hand, compiling 'no_shutdown.m' commenting out the ```CFNotificationCenterAddObserver``` function and reproducing the steps should result in 'shutdown.log' file contaning the log for 'no_shutdown' process.

Note that running a binary directly from ssh shell won't be useful, because presumably the os kindly shuts down the ssh process before rebooting, resulting in our process not logged.
So I tried to create two binaries: 'no_shutdown' (representing a malicious implant) and a 'launcher' that simply posix_spawns the first one and exits.


Note: another way to evade iShutdown seems to be to place a plist inside '/Library/LaunchDaemons' and start the binary with 'launchctl' utility.