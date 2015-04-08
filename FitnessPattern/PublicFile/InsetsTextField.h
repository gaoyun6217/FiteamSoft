//
//  InsetsTextField.h
//  Ihuoban
//
//  Created by GAOQINGGE on 14/11/27.
//  Copyright (c) 2014年 gqg.com.luntan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsTextField : UITextField
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end
