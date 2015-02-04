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

@property (strong, nonatomic) NSMutableArray *actions;

@end

@implementation HzActionSheetAdapter

#pragma mark - Public Interfaces

- (void)reset{
    [_actions removeAllObjects];
}

- (void)appendItemWithType:(HzActionSheetActionType)type title:(NSString *)title handler:(HzActionSheetActionBlock)actionHandler{
    if (!_actions) {
        self.actions = [NSMutableArray array];
    }
    
    NSAssert(title != nil, @"title should not be nil!");
    
    NSMutableDictionary *newActionInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:title, @"title", @(type), @"type", nil];
    if (actionHandler) {
        newActionInfo[@"action"] = actionHandler;
    }
    
    if (type == HzActionSheetActionCancel || type == HzActionSheetActionDestructive) {
        NSInteger index = 0;
        BOOL found = NO;
        for (NSMutableDictionary *actionInfo in _actions) {
            HzActionSheetActionType checkedType = [actionInfo[@"type"] integerValue];
            if (checkedType == type) {
                found = YES;
                //Only one Cancel Item or Destructive Item in actionSheet
                [_actions replaceObjectAtIndex:index withObject:newActionInfo];
                
                break;
            }
            index++;
        }
        
        if (!found) {
            [_actions addObject:newActionInfo];
        }
    }
    else {
        [_actions addObject:newActionInfo];
    }
}

- (void)showInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message inView:(UIView *)sourceView frame:(CGRect)sourceRect{
    if (iOS8) {
        UIAlertController *actionController = [UIAlertController alertControllerWithTitle:title
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSDictionary *actionInfo in _actions) {
            HzActionSheetActionType type = [actionInfo[@"type"] integerValue];
            if (type == HzActionSheetActionCancel) {
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionInfo[@"title"]
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction *action) {
                                                                         
                                                                         HzActionSheetActionBlock actionHandler = (HzActionSheetActionBlock)actionInfo[@"action"];
                                                                         actionHandler();
                                                                         
                                                                     }];
                [actionController addAction:cancelAction];
            }
            else if (type == HzActionSheetActionDestructive) {
                UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:actionInfo[@"title"]
                                                                            style:UIAlertActionStyleDestructive
                                                                          handler:^(UIAlertAction *action) {
                                                                         
                                                                              HzActionSheetActionBlock actionHandler = (HzActionSheetActionBlock)actionInfo[@"action"];
                                                                              actionHandler();
                                                                         
                                                                          }];
                [actionController addAction:destructiveAction];
            }
            else {
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:actionInfo[@"title"]
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
                                                                              
                                                                          HzActionSheetActionBlock actionHandler = (HzActionSheetActionBlock)actionInfo[@"action"];
                                                                          actionHandler();
                                                                              
                                                                      }];
                [actionController addAction:defaultAction];
            }
        }
        
        if (sourceView) {
            UIPopoverPresentationController *popover = actionController.popoverPresentationController;
            if (popover) {
                popover.sourceView = sourceView;
                popover.sourceRect = sourceRect;
                popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
        }
        
        [controller presentViewController:actionController animated:YES completion:nil];
    }
    else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
        for (NSDictionary *actionInfo in _actions) {
            HzActionSheetActionType type  = [actionInfo[@"type"] integerValue];
            NSInteger itemIndex = [actionSheet addButtonWithTitle:actionInfo[@"title"]];
            if (type == HzActionSheetActionCancel) {
                actionSheet.cancelButtonIndex = itemIndex;
            }
            else if (type == HzActionSheetActionDestructive) {
                actionSheet.destructiveButtonIndex = itemIndex;
            }
        }
        
        if (sourceView) {
            [actionSheet showFromRect:sourceRect inView:sourceView animated:YES];
        }
        else {
            [actionSheet showInView:controller.view];
        }
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

#ifdef DEBUG
    NSLog(@"%s, actions: %@, buttonIndex: %d", __FUNCTION__, _actions, buttonIndex);
#endif
    
    if (buttonIndex < 0 || buttonIndex >= _actions.count) {
        return;
    }
    
    NSDictionary *actionInfo = _actions[buttonIndex];
    if (actionInfo[@"action"]) {
        HzActionSheetActionBlock action = actionInfo[@"action"];
        action();
    }

}

@end
