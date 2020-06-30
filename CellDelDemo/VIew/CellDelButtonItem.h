//
//  CellDelButtonItem.h
//  SupervisionSel
//
//  Created by jhmac on 2020/6/28.
//  Copyright © 2020 admin. All rights reserved.
// https://blog.csdn.net/u010519146/article/details/42882635/#

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellDelButtonItem : UIControl
- (id)initWithFrame:(CGRect)frame WithImageName:(NSString *)imageName WithImageWidth:(CGFloat)imgWidth WithImageHeightPercentInItem:(CGFloat)imgPercent WithTitle:(NSString *)title WithFontSize:(CGFloat)fontSize WithFontColor:(UIColor *)color WithGap:(CGFloat)gap;
@end

NS_ASSUME_NONNULL_END
