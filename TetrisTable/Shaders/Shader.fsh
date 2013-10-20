//
//  Shader.fsh
//  TetrisTable
//
//  Created by Robert Homan on 10/19/13.
//  Copyright (c) 2013 Robert Homan. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
