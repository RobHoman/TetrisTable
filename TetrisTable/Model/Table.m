//
//  Table.m
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "Table.h"

@interface Table ()
{
    int _width;
    int _height;
    NSMutableArray *_rows; //use if we need to back the property
}

@property (nonatomic, strong) NSMutableArray *rows;

@end



@implementation Table

@synthesize rows = _rows; //back rows with _rows

- (id)init
{
    self = [super init];
    if (self)
    {
        _width = TABLE_WIDTH;
        _height = TABLE_HEIGHT;
        
        self.rows = [[NSMutableArray alloc] init];
        
        //point each row at its own array
        for (int i = 0; i < TABLE_HEIGHT; i++)
        {
            self.rows[i] = [[NSMutableArray alloc] init];
        }
        
        //initialize the table with all black cells
        for (int i = 0; i < TABLE_HEIGHT; i++)
        {
            for (int j = 0; j < TABLE_WIDTH; j++)
            {
                self.rows[i][j] = [[Cell alloc] init:0:0:0];
            }
        }
    }
    
    return self;
}

- (int)getWidth
{
    return _width;
}

- (int)getHeight
{
    return _height;
}

- (Cell *)getCell:(int) row :(int) column
{
    return self.rows[row][column];
}



@end
