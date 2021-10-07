//
//  View.m
//  计算器
//
//  Created by 差不多先生 on 2021/10/6.
//
// 定义这个常量，就可以不用在开发过程中使用mas_前缀。
#define MAS_SHORTHAND
// 定义这个常量，就可以让Masonry帮我们自动把基础数据类型的数据，自动装箱为对象类型。
#define MAS_SHORTHAND_GLOBALS
// 定义屏幕宽度和高度
#define WIDTH  self.frame.size.width
#define HEIGHT self.frame.size.height
#import "View.h"
#import "Masonry.h"
@implementation View
- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _topLabel = [[UILabel alloc] init];
    _topLabel.text = @"0";
    _topLabel.font = [UIFont systemFontOfSize:HEIGHT * 0.05];
    _topLabel.textColor = [UIColor whiteColor];
    _topLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_topLabel];
    [_topLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(WIDTH - WIDTH * 0.157);
        make.left.equalTo(WIDTH * 0.057);
        make.height.equalTo(HEIGHT * 0.2);
        make.top.equalTo(HEIGHT * 0.15);
    }];
    self.backgroundColor = [UIColor blackColor];
    _firstArray = [NSArray arrayWithObjects:@"AC", @"(", @")", @"/", @"7", @"8", @"9", @"*", @"4", @"5", @"6", @"-", @"1", @"2", @"3", @"+", @"0",@" ", @".", @"=", nil];
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 4; j++) {
            if (i == 4 && j == 0) {
                _zeroButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                _zeroButton.layer.cornerRadius = 40;
                _zeroButton.titleLabel.font = [UIFont systemFontOfSize:0.1 * self.frame.size.width];
                _zeroButton.layer.borderWidth = 2;
                [_zeroButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _zeroButton.backgroundColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1];
                _zeroButton.tag = 101 + i * 4 + j;
                [_zeroButton setTitle:_firstArray[i * 4 + j] forState:UIControlStateNormal];
                [self addSubview:_zeroButton];
                [_zeroButton addTarget:self action:@selector(return:) forControlEvents:UIControlEventTouchUpInside];
                [_zeroButton makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(WIDTH * 0.4286);
                    make.height.equalTo(WIDTH * 0.2);
                    make.left.equalTo(WIDTH * 0.057 + j * 0.2286 * WIDTH);
                    make.top.equalTo(HEIGHT * 0.40 + i * 0.2286 * WIDTH);;
                }];
                    j++;
                continue;
            }
                _normalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                _normalButton.tag = 101 + i * 4 + j;
                [_normalButton setTitle:_firstArray[i * 4 + j] forState:UIControlStateNormal];
                _normalButton.layer.cornerRadius = 38;
                _normalButton.layer.borderWidth = 2;
                [_normalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                if (i != 0 && j!= 3) {
                    _normalButton.backgroundColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1];
                } else if (j == 3) {
                    _normalButton.backgroundColor = [UIColor colorWithRed:236.0f / 255.0f green:146.0f / 255.0f blue:47.0f / 255.0f alpha:1];
                } else {
                    _normalButton.backgroundColor = [UIColor colorWithRed:148.0f / 255.0f green:148.0f / 255.0f blue:148.0f / 255.0f alpha:1];
                }
                [self addSubview:_normalButton];
                _normalButton.titleLabel.font = [UIFont systemFontOfSize:0.1 * self.frame.size.width];
            [_normalButton addTarget:self action:@selector(return:) forControlEvents:UIControlEventTouchUpInside];
                [_normalButton makeConstraints:^(MASConstraintMaker *make) {
                    make.width.and.height.equalTo(WIDTH * 0.2);
                    make.left.equalTo(WIDTH * 0.057 + j * 0.2286 * WIDTH);
                    make.top.equalTo(HEIGHT * 0.40 + i * 0.2286 * WIDTH);
                }];
            }
    }
    return self;
}
- (void) return: (UIButton*) cButton {
    [_delegate pressChange:cButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
