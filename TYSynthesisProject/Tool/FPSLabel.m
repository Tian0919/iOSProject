//
//  FPSLabel.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "FPSLabel.h"

@implementation FPSLabel{
    CADisplayLink *_displayLink;
    NSTimeInterval _lastTime;
    NSUInteger _count;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setContent];
    }
    return self;
}
- (void)setContent{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    self.userInteractionEnabled = NO;
    self.font = [UIFont systemFontOfSize:13];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(trick:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)trick:(CADisplayLink *)link{
   
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delat = link.timestamp - _lastTime;
    if (delat < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delat;
    _count = 0;
    CGFloat progress = fps / 60.0;
    
     UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    
    self.attributedText = text;
}
@end
