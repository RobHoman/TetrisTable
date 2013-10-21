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
}
@end

@implementation Table

- (id)init
{
    self = [super init];
    if (self)
    {
        _width = TABLE_WIDTH;
        _height = TABLE_HEIGHT;
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

@end
