//
//  Created by Andy on 2017/3/9.
//  Copyright © 2017年 wangyawei. All rights reserved.
//  

#import "AutoNumberLabelView.h"
#define LAB_TOP 10
#define LAB_SPACE 0

//  lable间距
#define LABEL_MARGIN  20
//  label居上高度
#define TOP_MARGIN 15
//  label距左
#define LEFT_MARGIN 20
//  字体距label顶部距离
#define FONT_TOP_MARGIN  3
//  label 默认背景色
#define kDefaultColor [UIColor colorWithRed:248/255.0 green:215/255.0 blue:176/255.0 alpha:1.0]
//  label 选中后的背景色
#define kSelectColor [UIColor colorWithRed:243/255.0 green:137/255.0 blue:42/255.0 alpha:1.0]
//  label 的默认字体颜色
#define kDefaultFontColor [UIColor colorWithRed:0x32/255.0 green:0x32/255.0 blue:0x32/255.0 alpha:1.0]


#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

#define rect(text,fontsize) [text boundingRectWithSize:CGSizeMake(kScreenW, 2000) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil]


@interface AutoNumberLabelView ()
{
    UILabel *_selectedLabel;//  记录被点击的label
    NSMutableArray* _labels;//  存放所有的label
}

@end


@implementation AutoNumberLabelView


-(NSMutableArray *)labels{
    if (!_labels) {
        _labels = [NSMutableArray arrayWithCapacity:3];
    }
    return _labels;
}


-(instancetype)initWithFrame:(CGRect)frame Buttons:(NSArray *)buttons FontSize:(float)fontSize
{
    self = [super initWithFrame:frame];
    if (self) {
        float topSelf = 0.0,bottomSelf = 0.0,heightSelf;
        int j = 0;//  记录上一行的位置,换行是改变frame时使用
        UILabel *al;
        UIImageView *imgView;
        for (int i = 0; i < buttons.count; i++) {
            NSDictionary *dic = [buttons objectAtIndex:i];
            NSString *tempString = [dic objectForKey:[[dic allKeys]lastObject]];
            CGRect rect = rect(tempString,fontSize);
            //  先固定第一个label或button的位置
            if (i == 0) {
                al = [[UILabel alloc]initWithFrame:CGRectMake(LEFT_MARGIN,CGRectGetMaxY(al.frame) + TOP_MARGIN , rect.size.width + fontSize/2, fontSize + FONT_TOP_MARGIN)];
           
                topSelf = CGRectGetMinY(al.frame);
              //  imgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(al.frame) - 16, CGRectGetMinY(al.frame), 13, 13)];
            }
            //  其余的就根据第一个的位置固定
            else {
                al = [[UILabel alloc]initWithFrame:CGRectMake(LABEL_MARGIN + CGRectGetMaxX(al.frame), j + TOP_MARGIN , rect.size.width + fontSize/2 , fontSize + FONT_TOP_MARGIN)];
               // imgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(al.frame) - 16, CGRectGetMinY(al.frame), 13, 13)];
            }
            //  如果需要显示图片可以打开
           // [imgView sd_setImageWithURL:[[dic allKeys] lastObject] placeholderImage:kPlaceholderImage];
            al.tag = i;
            [self.labels addObject:al];
            al.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnLabel:)];
            [al addGestureRecognizer:tap];
         
            al.backgroundColor = kDefaultColor;
            al.layer.cornerRadius = fontSize/2;
            al.layer.masksToBounds = YES;
            al.text = [dic objectForKey:[[dic allKeys]lastObject]];
            al.textAlignment = NSTextAlignmentCenter;
            //  判断是不是超过label或button的superview的宽的,保证及时换行
            if (CGRectGetMaxX(al.frame)  > CGRectGetMaxX(self.frame) - LEFT_MARGIN) {
                j = CGRectGetMaxY(al.frame);
                al.frame = CGRectMake(LEFT_MARGIN, j + TOP_MARGIN, rect.size.width+fontSize/2, fontSize + FONT_TOP_MARGIN);
                bottomSelf = CGRectGetMaxY(al.frame);
            }
            //  最后一个label或button时,记录下来视图的高度,视图的高度根据label或button定的
            if (i == buttons.count-1) {
                heightSelf = bottomSelf - topSelf;
                self.hight = heightSelf + TOP_MARGIN*2;//  视图的高度
            }
            al.font = [UIFont systemFontOfSize:fontSize];
            al.textColor = kDefaultFontColor;
            //  默认选择第一个label
            if (i == 0) {
                _selectedLabel = al;
                al.backgroundColor = kSelectColor;
                al.textColor = [UIColor whiteColor];
                [self tapOnLabel:tap];
            }
            [self addSubview:imgView];
            [self addSubview:al];
        }
        j=0;//  添加结束后,j要归0
    }
    return self;
}

//  点击事件
-(void)tapOnLabel:(UITapGestureRecognizer *)tap {

    _selectedLabel.backgroundColor = kDefaultColor;
    _selectedLabel.textColor = kDefaultFontColor;
    
    UILabel * lab = (UILabel*)tap.view;
    lab.backgroundColor = kSelectColor;
    lab.textColor = [UIColor whiteColor];
    
    _selectedLabel = lab;
    
    if (_delegate && [_delegate respondsToSelector:@selector(autoNumberLabelView:didSelectLabelAtIndex:)]) {
        [_delegate autoNumberLabelView:self didSelectLabelAtIndex:_selectedLabel.tag];
    }
}


@end
