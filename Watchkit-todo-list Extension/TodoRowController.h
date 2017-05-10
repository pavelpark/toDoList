//
//  TodoRowController.h
//  ToDo-List
//
//  Created by Pavel Parkhomey on 5/9/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchKit;

@interface TodoRowController : NSObject

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end
