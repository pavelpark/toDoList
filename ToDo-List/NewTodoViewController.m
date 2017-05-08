//
//  NewTodoViewController.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "NewTodoViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *contentTextFeild;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}
- (IBAction)addTodoPressed:(id)sender {
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    
    FIRDatabaseReference *userReference = [[databaseReference child:@"users"] child:currentUser.uid];
    
    FIRDatabaseReference *newTodoReference = [[userReference child:@"todos"] childByAutoId];
    
    [[newTodoReference child:@"title"] setValue:self.titleTextFeild.text];
    [[newTodoReference child:@"content"] setValue:self.contentTextFeild.text];
    
}

//    NSError *signOutError;
//    [[FIRAuth auth] signOut:&signOutError];

@end
