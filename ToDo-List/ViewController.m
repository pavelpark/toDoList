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
#import "toDo.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@property (weak, nonatomic) IBOutlet UITableView *todoTableView;

@property(strong,nonatomic) NSMutableArray *allTodos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.todoTableView.delegate = self;
    self.todoTableView.dataSource = self;
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
        
        self.allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            toDo *todo = [[toDo alloc]init];
            
            NSDictionary *todoData = child.value;
            
            todo.title = todoData[@"title"];
            todo.content = todoData[@"content"];

            [self.allTodos addObject:todo];
            [self.todoTableView reloadData];
            
        }
    }];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_allTodos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    toDo *child = [self.allTodos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", child.title];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", child.content];

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
