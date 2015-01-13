//
//  HzActionSheetAdapter.m
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "HzActionSheetAdapter.h"

@interface HzActionSheetAdapter () <UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *actionList;

@end

@implementation HzActionSheetAdapter

#pragma mark - Public Interfaces

- (void)appendAction:(ActionBlock)handler{
    if (!_actionList) {
        self.actionList = [[NSMutableArray alloc] init];
    }
    if (handler) {
        [_actionList addObject:handler];
    }
}

- (void)showInController:(UIViewController *)pController withTitle:(NSString *)title cancelText:(NSString *)cancelText ifOtherText:(NSString *)otherText, ...{
    NSMutableArray *argsArr = [NSMutableArray array];
    va_list params;
    va_start(params, otherText);
    id arg;
    if (otherText) {
        [argsArr addObject:otherText];
        int i = 1;
        while ((arg = va_arg(params, id)) != nil) {
            if (arg) {
                [argsArr addObject:(NSString *)arg];
            }
            
            i++;
        }
    }
    va_end(params);
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:title
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [controller addAction:cancelAction];
        
        for (int i = 0; i < argsArr.count; i++) {
            NSString *buttonText = (NSString *)argsArr[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonText
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               
                                                               if (_actionList.count > i) {
                                                                   ActionBlock handler = (ActionBlock)_actionList[i];
                                                                   handler();
                                                               }
                                                               
                                                           }];
            [controller addAction:action];
        }
        
        [pController presentViewController:controller animated:YES completion:nil];
    }
    else {
        UIActionSheet *actionSheet = nil;
        if (argsArr.count == 1) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:argsArr[0], nil];
        }
        else if (argsArr.count == 2) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:argsArr[0], argsArr[1], nil];
        }
        [actionSheet showInView:pController.view];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_actionList.count > buttonIndex) {
        ActionBlock handler = (ActionBlock)_actionList[buttonIndex];
        handler();
    }
}

@end
