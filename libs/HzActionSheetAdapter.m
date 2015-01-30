//
//  HzActionSheetAdapter.m
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "HzActionSheetAdapter.h"

#define iOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)

@interface HzActionSheetAdapter () <UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *actionList;

@end

@implementation HzActionSheetAdapter

#pragma mark - Public Interfaces

- (void)reset{
    [_actionList removeAllObjects];
}

- (void)appendAction:(ActionBlock)handler{
    if (!_actionList) {
        self.actionList = [[NSMutableArray alloc] init];
    }
    if (handler) {
        [_actionList addObject:handler];
    }
}

- (void)showInController:(UIViewController *)pController withTitle:(NSString *)title cancelText:(NSString *)cancelText destructiveText:(NSString *)destructiveText ifOtherText:(NSString *)otherText, ...{
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
        
        if (cancelText && cancelText.length > 0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
            [controller addAction:cancelAction];
        }
        
        if (destructiveText && destructiveText.length > 0) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveText
                                                                        style:UIAlertActionStyleDestructive
                                                                      handler:^(UIAlertAction *action) {
                                                                          
                                                                          _destructiveHandler();
                                                                          
                                                                      }];
            [controller addAction:destructiveAction];
        }

        
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
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], nil];
        }
        else if (argsArr.count == 2) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], argsArr[1], nil];
        }
        else if (argsArr.count == 3) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], argsArr[1], argsArr[2], nil];
        }
        else if (argsArr.count == 4) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], argsArr[1], argsArr[2], argsArr[3], nil];
        }
        [actionSheet showInView:pController.view];
    }
}

- (void)showInController:(UIViewController *)pController
                  inView:(UIView *)sourceView
                   frame:(CGRect)sourceRect
               withTitle:(NSString *)title
              cancelText:(NSString *)cancelText
         destructiveText:(NSString *)destructiveText
             ifOtherText:(NSString *)otherText, ...{
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
        
        if (cancelText && cancelText.length > 0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
            [controller addAction:cancelAction];
        }
        
        if (destructiveText && destructiveText.length > 0) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveText
                                                                        style:UIAlertActionStyleDestructive
                                                                      handler:^(UIAlertAction *action) {
                                                                          
                                                                          _destructiveHandler();
                                                                          
                                                                      }];
            [controller addAction:destructiveAction];
        }
        
        
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
        
        if (sourceView) {
            UIPopoverPresentationController *popover = controller.popoverPresentationController;
            if (popover) {
                popover.sourceView = sourceView;
                popover.sourceRect = sourceRect;
                popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
        }
        
        [pController presentViewController:controller animated:YES completion:nil];
    }
    else {
        UIActionSheet *actionSheet = nil;
        if (argsArr.count == 1) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], nil];
        }
        else if (argsArr.count == 2) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], argsArr[1], nil];
        }
        else if (argsArr.count == 3) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], argsArr[1], argsArr[2], nil];
        }
        else if (argsArr.count == 4) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:cancelText
                                        destructiveButtonTitle:destructiveText
                                             otherButtonTitles:argsArr[0], argsArr[1], argsArr[2], argsArr[3], nil];
        }
        
        if (sourceView) {
            [actionSheet showFromRect:sourceRect inView:sourceView animated:YES];
        }
        else {
            [actionSheet showInView:pController.view];
        }        
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_destructiveHandler) {
        if (buttonIndex == 0) {
            _destructiveHandler();
        }
        else {
            if (buttonIndex - 1 < _actionList.count) {
                ActionBlock handler = (ActionBlock)_actionList[buttonIndex - 1];
                handler();
            }
        }
        
    }
    else {
        if (buttonIndex < _actionList.count) {
            ActionBlock handler = (ActionBlock)_actionList[buttonIndex];
            handler();
        }
    }

}

@end
