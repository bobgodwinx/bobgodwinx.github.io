//
//  UACustomEvent.m
//  Places
//
//  Created by Bob Godwin Obi on 04.03.21.
//

#import "UACustomEvent.h"

@implementation UACustomEvent

- (instancetype)initWithEventName:(NSString *)eventName {
    self = [super init];
    if(self) {
        _eventName = eventName;
    }
    return  self;
}

- (void)say {
    __auto_type distance = 10;
    __auto_type time = 2.5;
    __auto_type speed = distance / time;
}

@end
