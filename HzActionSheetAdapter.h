//
//  HzActionSheetAdapter.h
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef void(^ActionBlock)(void);

@interface HzActionSheetAdapter : NSObject

/**
 *  注意：append的次数必须与OtherText的长度一致
 */
- (void)appendAction:(ActionBlock)handler;

/**
 *  注意：目前在低于iOS8的版本最多只能append两个ActionBlock
 *
 *  @param pController 在哪个controller显示该AlertView。（iOS8用，iOS8以下版本无效。）
 *  @param title       标题文本
 *  @param cancelText  取消按钮文本
 *  @param otherText   可变长按钮文本（长度必须和append的次数一致）
 */
- (void)showInController:(UIViewController *)pController
               withTitle:(NSString *)title
              cancelText:(NSString *)cancelText
             ifOtherText:(NSString *)otherText, ...;

@end
