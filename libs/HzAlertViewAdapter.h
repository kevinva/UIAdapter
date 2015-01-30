//
//  HzAlertViewAdapter.h
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HzActionType) {
    HzActionNormal = 0,
    HzActionCancel,
    HzActionDestructive
};

typedef void(^HzActionBlock)(void);

@interface HzAlertViewAdapter : NSObject

- (void)reset;
- (void)appendItemWithType:(HzActionType)type title:(NSString *)title handler:(HzActionBlock)actionHandler;
- (void)showInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message;


@end
