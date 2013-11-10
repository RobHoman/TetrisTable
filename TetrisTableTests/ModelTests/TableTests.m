//
//  TableTests.m
//  TetrisTable
//
//  Created by Robert Homan on 10/20/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Table.h"

@interface TableTests : XCTestCase {
    Table *_table;
}

@end

@implementation TableTests

- (void)setUp
{
    [super setUp];
    // Construct a table object
    _table = [[Table alloc] init];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testGetWidth
{
    int expected = TABLE_WIDTH;
    int actual = [_table getWidth];
    assert(expected == actual);
}

- (void)testGetHeight
{
    int expected = TABLE_HEIGHT;
    int actual = [_table getHeight];
    assert(expected == actual);
}

/**
 * Verify that every cell is initialized to black.
 */
- (void)testConstructor
{
    for (int i = 0; i < TABLE_HEIGHT; i++)
    {
        for (int j = 0; j < TABLE_WIDTH; j++)
        {
            Cell *cell = [_table getCell:i :j];
            assert([cell getRed] == 0);
            assert([cell getGreen] == 0);
            assert([cell getBlue] == 0);
        }
    }
}

@end
