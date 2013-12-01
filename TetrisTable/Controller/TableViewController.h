//
//  TableViewController.h
//  TetrisTable
//
//  Created by Homan, Rob on 11/29/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"

@interface TableViewController : UIViewController
{
    OpenGLView* _glView;

   
    
}

// Example method signature
//- (id)init:(int)red :(int) green :(int) blue;

//
//- (void)


//@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet OpenGLView *glView;

@end
