//
//  ViewController.m
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {

    
}

@end

@implementation ViewController

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)setupLayer {
    //_eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

- (void)setupContext {
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    
    if (!_context) {
        NSLog(@"Failed to initailize OpenGLES 2.0 context");
        exit(1);
        
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

- (void)setupRenderBuffer {
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

@end
