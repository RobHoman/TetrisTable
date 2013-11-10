//
//  OpenGLView.h
//  TetrisTable
//
//  Created by Robert Homan on 11/3/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
@interface OpenGLView : UIView {
    
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    
    GLuint _positionSlot;
    GLuint _colorSlot;
}

+ (Class)layerClass;

@end