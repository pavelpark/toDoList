//
//  FirebaseAPI.m
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/10/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+(void)fetchAllTodos:(AllTodosCompletion)completion{
    
    NSString *urlString = [NSString stringWithFormat:@"https://todo-list-6e3ba.firebaseio.com/users.json?auth=%@", APP_KEY];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"ROOT OBJECT: %@", rootObject);
    }] resume];
}

@end
