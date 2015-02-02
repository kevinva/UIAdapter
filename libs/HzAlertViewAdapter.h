//
//  HzAlertViewAdapter.h
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HzAlertViewActionType) {
    HzAlertViewActionNormal = 0,
    HzAlertViewActionCancel,
    HzAlertViewActionDestructive
};

typedef void(^HzAlertViewActionBlock)(void);

@interface HzAlertViewAdapter : NSObject

/**
 *  @brief When start showing alertView, it is better to call this method.
 */
- (void)reset;

/**
 *  @brief Setup up buttons item.
 *
 *  @param type          Choose which button you want to add: normal, cancel or destructive.
 *  @param title         Button title.
 *  @param actionHandler What will happen when the button is clicked.
 */
- (void)appendItemWithType:(HzAlertViewActionType)type title:(NSString *)title handler:(HzAlertViewActionBlock)actionHandler;

/**
 *  @brief Show alertView.
 *
 *  @param controller Which controller the alertView present from.(Only for iOS8. At iOS7 or below, you may set this param nil.)
 *  @param title      Title of alertView.
 *  @param message    Message of alertView.
 */
- (void)showInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message;


@end
