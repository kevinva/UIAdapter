//
//  HzAlertViewAdapter.m
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "HzAlertViewAdapter.h"

@interface HzAlertViewAdapter () <UIAlertViewDelegate>

@end

@implementation HzAlertViewAdapter

#pragma mark - Public Interfaces

- (void)showInController:(UIViewController *)controller withTitle:(NSString *)title message:(NSString *)message cancelText:(NSString *)cancelText ifConfirmText:(NSString *)confirmText{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        
        if (confirmText && confirmText.length > 0) {
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmText style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                _confirmHandler();
                
            }];
            [alertVC addAction:confirmAction];
        }

        [controller presentViewController:alertVC animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelText
                                                  otherButtonTitles:confirmText, nil];
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        self.confirmHandler();
    }
}

@end
