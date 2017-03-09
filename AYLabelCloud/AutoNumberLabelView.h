//
//  Created by Andy on 2017/3/9.
//  Copyright © 2017年 wangyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoNumberLabelView;

@protocol AutoNumberLabelViewDelegate <NSObject>

-(void)autoNumberLabelView:(AutoNumberLabelView *) autoNumberLabelView didSelectLabelAtIndex:(NSInteger)index;

@end

//  注意:在alloc后,需要重新设置frame
@interface AutoNumberLabelView : UIView

-(instancetype)initWithFrame:(CGRect)frame Buttons:(NSArray *)buttons FontSize:(float)fontSize;

@property (nonatomic, assign)CGFloat hight;
@property (nonatomic, weak)id<AutoNumberLabelViewDelegate>delegate;

@end
