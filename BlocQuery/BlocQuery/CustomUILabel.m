//
//  CustomUILabel.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/3/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "CustomUILabel.h"
#import <QuartzCore/QuartzCore.h>


@implementation CustomUILabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;

    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
        
    }
    return self;
}

// for border and rounding
-(void) drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
}

//- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
//    
//}

// for inset
-(void) drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {10, 15, 10, 15};
    
    [super drawTextInRect: UIEdgeInsetsInsetRect(rect, insets)];
}


@end
