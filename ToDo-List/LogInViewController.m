//
//  LogInViewController.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "LogInViewController.h"

@import FirebaseAuth;

@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;

@end

@implementation LogInViewController

- (IBAction)loginPressed:(id)sender {
   [[FIRAuth auth] signInWithEmail:self.emailTextFeild.text password:self.passwordTextFeild.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
       if (error) {
           NSLog(@"Error Signing in: %@", error.localizedDescription);
       }
       if (user) {
           NSLog(@"Logged In User: %@", user);
           [self dismissViewControllerAnimated:YES completion:nil];
       }
   }];
}

- (IBAction)signupPressed:(id)sender {
    
    [[FIRAuth auth] createUserWithEmail:self.emailTextFeild.text password:self.passwordTextFeild.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Signing Up New User: %@", error.localizedDescription);
        }
        if (user) {
            NSLog(@"Successfully Signed Up: %@", user);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

@end
