//
//  OpenGLView.m
//  TetrisTable
//
//  Created by Robert Homan on 11/3/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

#import "OpenGLView.h"
#import "CC3GLMatrix.h"
#import "Table.h"


typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

@interface OpenGLView () {
    Table* _table;
    Vertex* _vertices;
    GLushort* _indices;
}

@end

@implementation OpenGLView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
        [self setupDepthBuffer];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        [self compileShaders];
    }
    return self;
}

- (void)render:(CADisplayLink*)displayLink
{
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    // make the projection matrix
    //CC3GLMatrix *projection = [CC3GLMatrix matrix];
    //float h = 4.0f * self.frame.size.height / self.frame.size.width;
    //[projection populateFromFrustumLeft:-2 andRight:2 andBottom:-h/2 andTop:h/2 andNear:4 andFar:10];
    //glUniformMatrix4fv(_projectionUniform, 1, 0, projection.glMatrix);
    
    // make the modelView matrix
    //CC3GLMatrix *modelView = [CC3GLMatrix matrix];
    //[modelView populateFromTranslation:CC3VectorMake(0, 0, -5)];
    //[modelView populateFromTranslation:CC3VectorMake(sin(CACurrentMediaTime()), 0, -7)];
    
    // incorporate rotation
    //_currentRotation += displayLink.duration * 90;
    //[modelView rotateBy:CC3VectorMake(_currentRotation, _currentRotation, 0)];
    
    // rotation and translation
    //glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    // set portion of view used for rendering
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    // 2
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    
    // 3
    int numIndices = [_table getWidth] * [_table getHeight] * 2 * 3; // 3 indices per triangle, 2 triangles per square
    //int numIndices = 36;
    glDrawElements(GL_TRIANGLES, numIndices,
                   GL_UNSIGNED_SHORT, 0);
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)setModel:(Table*)model
{
    _table = model;
    [self setupVBOs]; // when the model is set, the VBOs must be constructed
}

- (void)makeVerticesAndIndices
{
    float width = .2;
    float height = .1;
    
    int switchValue = 0;
    
    for (int i = 0; i < [_table getHeight]; i++)
    {
        for (int j = 0; j < [_table getWidth]; j++)
        {
            //now make the vertices and indices
            float baseX = -1 + j * width;
            float baseY = -1 + i * height;
            
            Cell* cell = [_table getCell:i :j];
            
            float r = ((float)[cell getRed]) / 255;
            float g = ((float)[cell getGreen]) / 255;
            float b = ((float)[cell getBlue]) / 255;
            float a = 1;
            
            Vertex vertex1 = [self makeVertex:baseX :baseY + height :0 :r :g :b :a];
            Vertex vertex2 = [self makeVertex:baseX + width :baseY + height :0 :r :g :b :a];
            Vertex vertex3 = [self makeVertex:baseX + width :baseY :0 :r :g :b :a];
            Vertex vertex4 = [self makeVertex:baseX :baseY :0 :r :g :b :a];
            
            int startIndex = ((i * [_table getWidth]) + j) * 4;
            _vertices[startIndex] = vertex1;
            _vertices[startIndex + 1] = vertex2;
            _vertices[startIndex + 2] = vertex3;
            _vertices[startIndex + 3] = vertex4;

            int indicesStartIndex = ((i * [_table getWidth]) + j) * 6;
            GLushort glStartIndex = startIndex;
            _indices[indicesStartIndex] = glStartIndex;
            _indices[indicesStartIndex + 1] = glStartIndex + 1;
            _indices[indicesStartIndex + 2] = glStartIndex + 2;
            _indices[indicesStartIndex + 3] = glStartIndex + 2;
            _indices[indicesStartIndex + 4] = glStartIndex + 3;
            _indices[indicesStartIndex + 5] = glStartIndex;
            
        }
    }
}

- (Vertex)makeVertex:(float) x :(float) y :(float) z :(float) r :(float) g :(float) b :(float) a
{
    Vertex v;
    v.Position[0] = x;
    v.Position[1] = y;
    v.Position[2] = z;
    v.Color[0] = r;
    v.Color[1] = g;
    v.Color[2] = b;
    v.Color[3] = a;
    return v;
}

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (void)setupVBOs
{
    //malloc the data object buffers
    int numVertices = [_table getWidth] * [_table getHeight] * 4; //4 vertices per square
    _vertices = (Vertex *) malloc(numVertices * sizeof(Vertex));
    int numIndices = [_table getWidth] * [_table getHeight] * 2 * 3; // 3 indices per triangle, 2 triangles per square
    _indices = (GLushort *) malloc(numIndices * sizeof(GLushort));
    
    //populate the data object buffers
    [self makeVerticesAndIndices];
    
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, numVertices * sizeof(_vertices[0]), _vertices, GL_STATIC_DRAW);
    
    GLuint indexBuffer;
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, numIndices * sizeof(_indices[0]), _indices, GL_STATIC_DRAW);
    
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType
{
    
    // load the shader
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName
                                                           ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
                                                       encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    // create the shader
    GLuint shaderHandle = glCreateShader(shaderType);
    
    // convert shader source from NSString to C string
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    // compile the shader
    glCompileShader(shaderHandle);
    
    // verify it compiled, or log compile errors
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
    
}

- (void)compileShaders
{
    
    // compile the vertex and fragemnt shaders
    GLuint vertexShader = [self compileShader:@"SimpleVertex"
                                     withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"SimpleFragment"
                                       withType:GL_FRAGMENT_SHADER];
    // link shaders into a complete program
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);
    
    // check for link errors
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    // use these linked shaders
    glUseProgram(programHandle);
    
    // get input values for vertex shader, enable use of arrays... ??
    _positionSlot = glGetAttribLocation(programHandle, "Position");
    _colorSlot = glGetAttribLocation(programHandle, "SourceColor");
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
    
    // set the projection input variable
    //_projectionUniform = glGetUniformLocation(programHandle, "Projection");
    
    // set the modelView input variable
    //_modelViewUniform = glGetUniformLocation(programHandle, "Modelview");
}

- (void)setupLayer
{
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

- (void)setupContext
{
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

- (void)setupDepthBuffer
{
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
}

- (void)setupRenderBuffer
{
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupFrameBuffer
{
    GLuint framebuffer;
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, _colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}

@end
