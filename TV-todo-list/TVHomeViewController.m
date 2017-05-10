//
//  TVHomeViewController.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/9/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "TVHomeViewController.h"
#import "toDo.h"
#import "FirebaseAPI.h"

@interface TVHomeViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSArray<toDo *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    [FirebaseAPI fetchAllTodos:^(NSArray<toDo *> *allTodos) {
        NSLog(@"%@",allTodos);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray<toDo *> *)allTodos{
    toDo *firstTodo = [[toDo alloc]init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is a todo.";
    
    toDo *secondTodo = [[toDo alloc]init];
    secondTodo.title = @"Second Todo";
    secondTodo.content = @"This is another amazing todo.";
    
    toDo *thirdTodo = [[toDo alloc]init];
    thirdTodo.title = @"Third Todo";
    thirdTodo.content = @"This is another another todo.";
    
    return @[firstTodo, secondTodo, thirdTodo];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

@end
