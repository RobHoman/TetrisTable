//
//  Cell.h
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject

- (id)init:(int)red :(int) green :(int) blue;
- (int)getRed;
- (int)getGreen;
- (int)getBlue;

- (void)setColor:(int)red :(int) green :(int) blue;

@end
