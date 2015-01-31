//
//  ViewController.m
//  AdapterDemo
//
//  Created by Zander Harrison on 15/1/30.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "HzAlertViewAdapter.h"

@interface ViewController ()

@property (strong, nonatomic) HzAlertViewAdapter *alertViewAdapter;

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
}

- (IBAction)showAlertView:(id)sender {
    self.alertViewAdapter = [[HzAlertViewAdapter alloc] init];
    [_alertViewAdapter appendItemWithType:HzActionNormal title:@"OK" handler:^{
        
        NSLog(@"OK clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzActionNormal title:@"OK1" handler:^{
        
        NSLog(@"OK1 clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzActionNormal title:@"OK2" handler:^{
        
        NSLog(@"OK2 clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzActionDestructive title:@"Delete" handler:^{
        
        NSLog(@"Delete clicked!");
        
    }];
    [_alertViewAdapter appendItemWithType:HzActionCancel title:@"Cancel" handler:^{
        
        NSLog(@"Cancel clicked!");
        
    }];

    [_alertViewAdapter showInController:self title:@"Warning" message:@"AlertView Testing!!!!"];
}
@end
