//
//  SimpleTableGenerator1.h
//  TetrisTable
//
//  Created by Homan, Rob on 12/1/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Table.h"

@interface SimpleTableGenerator1 : NSObject

- (id)init;

// later, we will let the generators manage the clock
- (BOOL)hasNext;

- (Table*)getNextTable;

@end
