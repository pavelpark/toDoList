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
@import Firebase;

@interface ViewController ()

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self checkUserStatus];
    [self setupFirebase];

}


-(void)checkUserStatus{
    
    if (![[FIRAuth auth] currentUser]) {
        
        LogInViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

-(void)setupFirebase{
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    
    NSLog(@"USER REFERENCE: %@", self.userReference);
}

-(void)startMonitoringTodoUpdates{
    
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];

            //for lab new TOdo to alltodos will need to append to the array.
            
            NSLog(@"Todo Title: %@ - Content: %@", todoTitle, todoContent);
        }
    }];
}

@end
