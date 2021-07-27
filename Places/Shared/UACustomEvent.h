//
//  UACustomEvent.h
//  Places
//
//  Created by Bob Godwin Obi on 04.03.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UACustomEvent : NSObject

@property (nonatomic, copy) NSString *eventName;
- (instancetype)initWithEventName:(NSString *)eventName;

@end

NS_ASSUME_NONNULL_END
