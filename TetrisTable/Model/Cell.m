//
//  Cell.m
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "Cell.h"

@interface Cell ()
{
    int _red;
    int _green;
    int _blue;
}

@end


@implementation Cell
- (id)init:(int)red :(int) green :(int) blue
{
    self = [super init];
    if (self)
    {
        _red = red;
        _green = green;
        _blue = blue;
    }
    return self;
}

- (int)getRed
{
    return _red;
}

- (int)getGreen
{
    return _green;
}

- (int)getBlue
{
    return _blue;
}


@end
