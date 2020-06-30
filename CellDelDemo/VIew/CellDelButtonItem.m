//
//  CellDelButtonItem.m
//  SupervisionSel
//
//  Created by jhmac on 2020/6/28.
//  Copyright © 2020 admin. All rights reserved.
//

#import "CellDelButtonItem.h"

@implementation CellDelButtonItem
{
    UIImageView *_imageView;
    UILabel *_label;
}
- (id)initWithFrame:(CGRect)frame
      WithImageName:(NSString *)imageName
     WithImageWidth:(CGFloat)imgWidth
WithImageHeightPercentInItem:(CGFloat)imgPercent
          WithTitle:(NSString *)title
       WithFontSize:(CGFloat)fontSize
      WithFontColor:(UIColor *)color
            WithGap:(CGFloat)gap{
    self.backgroundColor=[UIColor clearColor];
    self=[super initWithFrame:frame];
    if (self) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-imgWidth)/2, 0, imgWidth, imgPercent*frame.size.height)];
        if (imageName) {
            _imageView.image=[UIImage imageNamed:imageName];
        }
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, gap+_imageView.frame.size.height, frame.size.width, (1-imgPercent)*frame.size.height)];
        _label.text=title;
        _label.textColor=color;
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:fontSize];
        [self addSubview:_label];
        
        
    }
    return self;
}

@end
