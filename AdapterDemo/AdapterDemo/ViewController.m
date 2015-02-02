//
//  ViewController.m
//  AdapterDemo
//
//  Created by Zander Harrison on 15/1/30.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "HzAlertViewAdapter.h"
#import "HzActionSheetAdapter.h"

@interface ViewController ()

@property (strong, nonatomic) HzAlertViewAdapter *alertViewAdapter;
@property (strong, nonatomic) HzActionSheetAdapter *actionSheet;

- (IBAction)showActionSheet:(id)sender;
- (IBAction)showAlertView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActionSheet:(id)sender {
    self.actionSheet = [[HzActionSheetAdapter alloc] init];
    [_actionSheet appendItemWithType:HzActionSheetActionNormal title:@"Camera" handler:^{
        
        NSLog(@"Camera clicked!");
        
    }];
    [_actionSheet appendItemWithType:HzActionSheetActionNormal title:@"Album" handler:^{
        
        NSLog(@"Album clicked!");
        
    }];
    [_actionSheet appendItemWithType:HzActionSheetActionCancel title:@"Cancel" handler:^{
        
        NSLog(@"Cancel clicked!");
        
    }];
    [_actionSheet appendItemWithType:HzActionSheetActionDestructive title:@"Delete" handler:^{
        
        NSLog(@"delete clicked!");
        
    }];
    [_actionSheet showInController:self title:@"Warning" message:@"Please choose..." inView:nil frame:CGRectZero];
    
}

- (IBAction)showAlertView:(id)sender {
    self.alertViewAdapter = [[HzAlertViewAdapter alloc] init];
    [_alertViewAdapter appendItemWithType:HzAlertViewActionNormal title:@"OK" handler:^{
        
        NSLog(@"OK clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzAlertViewActionNormal title:@"OK1" handler:^{
        
        NSLog(@"OK1 clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzAlertViewActionNormal title:@"OK2" handler:^{
        
        NSLog(@"OK2 clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzAlertViewActionDestructive title:@"Delete" handler:^{
        
        NSLog(@"Delete clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzAlertViewActionCancel title:@"Cancel" handler:^{
        
        NSLog(@"Cancel clicked!");
        
    }];

    [_alertViewAdapter showInController:self title:@"Warning" message:@"AlertView Testing!!!!"];
}
@end
