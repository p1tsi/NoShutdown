#include <stdlib.h>
#include <spawn.h>
#import <Foundation/Foundation.h>


#define BINARY "/private/var/db/com.apple.xpc.roleaccountd.staging/no_shutdown"

int main(){
    pid_t new_pid;
    
    char real_app[] = BINARY;
    char *argv[] = { BINARY, NULL };
    posix_spawnattr_t attr;
    short flags;
    posix_spawnattr_init(&attr);
    posix_spawnattr_getflags(&attr, &flags);

    posix_spawnattr_setflags(&attr, flags);
    posix_spawn(&new_pid, real_app, NULL, &attr, argv, NULL);
    
    NSLog(@"Spawn process with pid: %d", new_pid);

    return 0;
}
