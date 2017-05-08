//
//  ViewController.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "ViewController.h"
#import "LogInViewController.h"

@import FirebaseAuth;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self checkUserStatus];
}


-(void)checkUserStatus{
    if (![[FIRAuth auth] currentUser]) {
        
        LogInViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
    }
}

@end
