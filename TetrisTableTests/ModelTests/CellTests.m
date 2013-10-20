//
//  Cell.m
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Cell.h"

#define RED_VALUE ((int) 30)
#define GREEN_VALUE ((int) 200)
#define BLUE_VALUE ((int) 43)

@interface CellTests : XCTestCase {
    Cell *_cell;
}

@end

@implementation CellTests

- (void)setUp
{
    [super setUp];
    // Construct a Cell object
    _cell = [[Cell alloc] init:RED_VALUE:GREEN_VALUE:BLUE_VALUE];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testGetRed
{
    assert(RED_VALUE == [_cell getRed]);
}

- (void)testGetGreen
{
    assert(GREEN_VALUE == [_cell getGreen]);
}

- (void)testGetBlue
{
    assert(BLUE_VALUE == [_cell getBlue]);
}
@end
