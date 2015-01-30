//
//  HzActionSheetAdapter.h
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(void);

@interface HzActionSheetAdapter : NSObject

@property (strong, nonatomic) ActionBlock destructiveHandler;

/**
 *  注意：append的次数必须与OtherText的长度一致
 */
- (void)appendAction:(ActionBlock)handler;

/**
 *  清除ActionBlock列表。每次显示一次actionSheet时最后先调用一下
 */
- (void)reset;

/**
 *  @brief 目前在低于iOS8的版本最多只能append四个ActionBlock (deprecated)
 *
 *  @param pController 在哪个controller显示该AlertView。（iOS8用，iOS8以下版本无效。）
 *  @param title       标题文本
 *  @param cancelText  取消按钮文本
 *  @param destructive 危险警示按钮文本
 *  @param otherText   可变长按钮文本（长度必须和append的次数一致）
 */
- (void)showInController:(UIViewController *)pController
               withTitle:(NSString *)title
              cancelText:(NSString *)cancelText
         destructiveText:(NSString *)destructiveText
             ifOtherText:(NSString *)otherText, ...;

/**
 *  @brief 目前在低于iOS8的版本最多只能append四个ActionBlock。
 *
 *  @param pController 在哪个controller显示该AlertView。（iOS8用，iOS8以下版本无效。）
 *  @param sourceView  从哪个sourceView弹出（iPhone版使用可留空）
 *  @param sourceRect  sourceRect的位置（在iPad版中用于popover箭头的指向）
 *  @param title       标题文本
 *  @param cancelText  取消按钮文本
 *  @param destructive 危险警示按钮文本
 *  @param otherText   可变长按钮文本（长度必须和append的次数一致）
 */
- (void)showInController:(UIViewController *)pController
                  inView:(UIView *)sourceView
                   frame:(CGRect)sourceRect
               withTitle:(NSString *)title
              cancelText:(NSString *)cancelText
         destructiveText:(NSString *)destructiveText
             ifOtherText:(NSString *)otherText, ...;

@end
