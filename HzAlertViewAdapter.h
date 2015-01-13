//
//  HzAlertViewAdapter.h
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef void(^ConfirmBlock)(void);

@interface HzAlertViewAdapter : NSObject

@property (strong, nonatomic) ConfirmBlock confirmHandler;

/**
 *  显示AlertView
 *
 *  @param controller  在哪个controller显示该AlertView。（iOS8用，iOS8以下版本无效。）
 *  @param title       标题文本，如果没标题，请设为""。（不建议设为nil。）
 *  @param message     警告消息文本。
 *  @param cancelText  取消按钮文本。
 *  @param confirmText 确认按钮文本。（若不显示确认按钮，请设为nil。）
 */
- (void)showInController:(UIViewController *)controller
               withTitle:(NSString *)title
                 message:(NSString *)message
              cancelText:(NSString *)cancelText
           ifConfirmText:(NSString *)confirmText ;

@end
