//
//  TableViewController.m
//  TetrisTable
//
//  Created by Homan, Rob on 11/29/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end



@implementation TableViewController

@synthesize glView=_glView;

- (id)init
{
    self = [super init];
    if (self)
    {
        //initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.glView = [[OpenGLView alloc] initWithFrame:screenBounds];
    
    self.view = self.glView;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // TODO: Connect the display link to the update controller method here
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}

/**
 * Get a new table model, depending on how much time has passed. Then
 * pass that model to the OpenGLView to be rendered.
 */
- (void)update:(CADisplayLink*)displayLink
{
    [self.glView render:displayLink];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
