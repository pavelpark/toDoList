//
//  FirebaseAPI.h
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/10/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "toDo.h"

typedef void(^AllTodosCompletion)(NSArray<toDo *> *allTodos);
@interface FirebaseAPI : NSObject

+(void)fetchAllTodos:(AllTodosCompletion)completion;
@end
