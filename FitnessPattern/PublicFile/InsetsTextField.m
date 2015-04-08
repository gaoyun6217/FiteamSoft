//
//  InsetsTextField.m
//  Ihuoban
//
//  Created by GAOQINGGE on 14/11/27.
//  Copyright (c) 2014年 gqg.com.luntan. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 30 , 0 );
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 30 , 0 );
}

@end
