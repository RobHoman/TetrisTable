//
//  SimpleTableGenerator1.m
//  TetrisTable
//
//  Created by Homan, Rob on 12/1/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "SimpleTableGenerator1.h"

@interface SimpleTableGenerator1 ()
{
    BOOL _bit;
}

@end

@implementation SimpleTableGenerator1


- (id)init
{
    self = [super init];
    if (self)
    {

    }
    
    return self;
}

- (BOOL)hasNext
{
    return NO;
}

- (Table*)getNextTable
{
    Table* table = [[Table alloc] init];
    
    // Color a different square, depending on the bit
    Cell* cell;
    if (_bit)
    {
        cell = [table getCell:2 :2];
    }
    else
    {
        cell = [table getCell:5 :5];
    }
    
    [cell setColor:255 :0 :0];
    
    _bit = !_bit;
    
    
    return table;
}

@end
