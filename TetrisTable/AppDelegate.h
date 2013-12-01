//
//  AppDelegate.h
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "OpenGLView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    OpenGLView* _glView;

}

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, retain) IBOutlet OpenGLView *glView;

@end
