//
//  toDo.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/9/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "toDo.h"

@implementation toDo

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    
    self.title = title;
    self.content = content;
    
    return self;
}

@end
