//
//  ViewController.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "ViewController.h"
#import "LogInViewController.h"
#import "NewTodoViewController.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController () <UITableViewDataSource>

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;
@property(strong,nonatomic) NSMutableArray *allTodos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self checkUserStatus];

}


-(void)checkUserStatus{
    
    //If function for the checkUserStats
    
    if (![[FIRAuth auth] currentUser]) {
        
        LogInViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

//These are the else functions.

-(void)setupFirebase{
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    
    NSLog(@"USER REFERENCE: %@", self.userReference);
}

//Else Function.

-(void)startMonitoringTodoUpdates{
    
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];

            [self.allTodos addObject:todoData];
//            [self.todoTableView reloadData];
            
            NSLog(@"Todo Title: %@ - Content: %@", todoTitle, todoContent);
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.allTodos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *currentToDo = self.allTodos[indexPath.row];
    NSString *todoTitle = currentToDo[@"title"];
    NSString *todoContent = currentToDo[@"content"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Todo Title: %@ - Content: %@", todoTitle, todoContent];
    
    return cell;
}

- (IBAction)logoutButtonPressed:(id)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    [self checkUserStatus];
    NSLog(@"User Logged Out");
}

- (IBAction)showAndHideController:(id)sender {
    [self.childViewControllers[0] view].hidden = ![self.childViewControllers[0] view].hidden;
}


@end
