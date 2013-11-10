//
//  Table.h
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Cell.h"


#define TABLE_WIDTH ((int) 10)
#define TABLE_HEIGHT ((int) 20)

@interface Table : NSObject

- (id)init;
- (int)getWidth;
- (int)getHeight;
- (Cell *)getCell:(int) row :(int) column;
@end
