//
//  HzAlertViewAdapter.m
//  FastcompanyiPhone
//
//  Created by Zander Harrison on 14/12/31.
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "HzAlertViewAdapter.h"

#define isiOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)

static NSString * const kKeyActionCancel = @"cancel";
static NSString * const kKeyActionDestructive = @"destructive";
static NSString * const kKeyActionNormal = @"noraml";

@interface HzAlertViewAdapter () <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *actions;

@end

@implementation HzAlertViewAdapter

#pragma mark - Public Interfaces

- (void)reset{
    [_actions removeAllObjects];
}

- (void)appendItemWithType:(HzAlertViewActionType)type title:(NSString *)title handler:(HzAlertViewActionBlock)actionHandler{
    if (!_actions) {
        self.actions = [NSMutableArray array];
    }
    
    NSAssert(title != nil, @"title should not be nil!");
    
    NSMutableDictionary *newActionInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:title, @"title", @(type), @"type", nil];
    if (actionHandler) {
        newActionInfo[@"action"] = actionHandler;
    }
    
    if (type == HzAlertViewActionCancel || type == HzAlertViewActionDestructive) {
        NSInteger index = 0;
        BOOL found = NO;
        for (NSMutableDictionary *actionInfo in _actions) {
            HzAlertViewActionType checkedType = [actionInfo[@"type"] integerValue];
            if (checkedType == type) {
                found = YES;
                //Only one Cancel Item or Destructive Item in alertView
                [_actions replaceObjectAtIndex:index withObject:newActionInfo];
                
                break;
            }
            index++;
        }
        
        if (!found) {
            if (type == HzAlertViewActionCancel) {
                //Cancel Item must always be the first(index 0, the same as system).
                [_actions insertObject:newActionInfo atIndex:0];
            }
            else {
                [_actions addObject:newActionInfo];
            }
        }
    }
    else {
        [_actions addObject:newActionInfo];
    }    
}

- (void)showInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message{
    if (!_actions || _actions.count == 0) {
        return;
    }
    
#ifdef DEBUG
    NSLog(@"%s, actions: %@", __FUNCTION__, _actions);
#endif
    
    if (isiOS8) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        for (NSDictionary *actionInfo in _actions) {
            HzAlertViewActionType type = [actionInfo[@"type"] integerValue];
            if (type == HzAlertViewActionCancel) {
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionInfo[@"title"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    HzAlertViewActionBlock actionHandler = (HzAlertViewActionBlock)actionInfo[@"action"];
                    if (actionHandler) {
                        actionHandler();
                    }
                    
                    
                }];
                [alertVC addAction:cancelAction];
            }
            else if (type == HzAlertViewActionDestructive) {
                UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:actionInfo[@"title"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    HzAlertViewActionBlock actionHandler = (HzAlertViewActionBlock)actionInfo[@"action"];
                    if (actionHandler) {
                        actionHandler();
                    }
                    
                    
                }];
                [alertVC addAction:destructiveAction];
            }
            else {
                UIAlertAction *normalAction = [UIAlertAction actionWithTitle:actionInfo[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    HzAlertViewActionBlock actionHandler = (HzAlertViewActionBlock)actionInfo[@"action"];
                    if (actionHandler) {
                        actionHandler();
                    }
                    
                    
                }];
                [alertVC addAction:normalAction];
            }
        }
        
        [controller presentViewController:alertVC animated:YES completion:nil];
    }
    else {
        NSString *cancelTitle = nil;
        for (NSDictionary *actionInfo in _actions) {
            HzAlertViewActionType type = [actionInfo[@"type"] integerValue];
            if (type == HzAlertViewActionCancel) {
                cancelTitle = actionInfo[@"title"];
            }
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:nil];
        
        for (NSDictionary *actionInfo in _actions) {
            HzAlertViewActionType type = [actionInfo[@"type"] integerValue];
            if (type != HzAlertViewActionCancel) {
                [alertView addButtonWithTitle:actionInfo[@"title"]];
            }
            
        }
        
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //"Cancel" item is always be at the 0 index no matter which index is appended.;
    if (buttonIndex < 0 || buttonIndex >= _actions.count) {
        return;
    }
    
    NSDictionary *actionInfo = (NSDictionary *)_actions[buttonIndex];
    if (actionInfo[@"action"]) {
        HzAlertViewActionBlock action = (HzAlertViewActionBlock)actionInfo[@"action"];
        action();
    }   
}

@end
