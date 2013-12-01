//
//  TableViewController.m
//  TetrisTable
//
//  Created by Homan, Rob on 11/29/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "TableViewController.h"
#import "SimpleTableGenerator1.h"

@interface TableViewController ()
{
    int _lastUpdateTime;
    SimpleTableGenerator1* _tableGenerator;
}

@end



@implementation TableViewController

@synthesize glView=_glView;

- (id)init
{
    self = [super init];
    if (self)
    {
        //initialization
        _lastUpdateTime = -1; // -1 implies it has never been updated
        _tableGenerator = [[SimpleTableGenerator1 alloc] init];
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
    
    //set the first model
    [self.glView setModel:[[Table alloc] init]];
    
    self.view = self.glView;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Connect the display link to a controller method
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}

/**
 * Get a new table model, depending on how much time has passed. Then
 * pass that model to the OpenGLView to be rendered.
 */
- (void)update:(CADisplayLink*)displayLink
{
    // if a 'n' seconds have passed, get a new table model.
    int n = 2;
    int currentTime = CACurrentMediaTime();
    if (currentTime - _lastUpdateTime > n)
    {
        _lastUpdateTime = currentTime;
        
        // then set the model on the view and render
        Table* nextTable = [_tableGenerator getNextTable];
        [self.glView setModel:nextTable];
        [self.glView render:displayLink];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
