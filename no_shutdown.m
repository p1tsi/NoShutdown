#import <Foundation/Foundation.h>

void 
will_shutdown(
    CFNotificationCenterRef center, 
    void* observer, 
    CFStringRef name, 
    const void* object, 
    CFDictionaryRef userInfo
){
    NSLog(@"Exiting...");
    exit(0);
}


int 
main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"Init poc");
        
        NSLog(@"Start listening to 'com.apple.springboard.deviceWillShutDown' notification...");
    
        // Comment out the following function if you want to test the case in which the binary appears inside shutdown.log file
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        NULL,
                                        will_shutdown,
                                        CFSTR("com.apple.springboard.deviceWillShutDown"),
                                        NULL,
                                        CFNotificationSuspensionBehaviorDeliverImmediately);
        
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop run];
    }
    
    return 0;
}
