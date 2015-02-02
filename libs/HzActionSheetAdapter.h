//
//  HzActionSheetAdapter.h
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HzActionSheetActionType) {
    HzActionSheetActionNormal = 0,
    HzActionSheetActionCancel,
    HzActionSheetActionDestructive
};

typedef void(^HzActionSheetActionBlock)(void);

@interface HzActionSheetAdapter : NSObject

/**
 *  @brief When start showing actionSheet, it is better to call this method.
 */
- (void)reset;

/**
 *  @brief Setup up buttons item.
 *
 *  @param type          Choose which button you want to add: normal, cancel or destructive.
 *  @param title         Button title.
 *  @param actionHandler What will happen when the button is clicked.
 */
- (void)appendItemWithType:(HzActionSheetActionType)type title:(NSString *)title handler:(HzActionSheetActionBlock)actionHandler;

/**
 *  @brief Show actionSheet.
 *
 *  @param controller Which controller the actionSheet present from.(Only for iOS8. At iOS7 or below, you can set this param nil.)
 *  @param title      Title of actionSheet.
 *  @param message    Message of actionSheet.
 *  @param sourceView The view which the actionSheet arrow point to.(Only for iPad at iOS8, At iPhone, you may set this param nil.)
 *  @param sourceRect Usually the sourceView position.
 */
- (void)showInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message inView:(UIView *)sourceView frame:(CGRect)sourceRect;


@end
