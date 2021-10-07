//
//  View.h
//  计算器
//
//  Created by 差不多先生 on 2021/10/6.
//

#import <UIKit/UIKit.h>

@protocol viewDelegate <NSObject>

- (void) pressChange: (UIButton*) cButton;

@end

NS_ASSUME_NONNULL_BEGIN

@interface View : UIView 
@property (nonatomic, strong) UILabel* topLabel;
@property (nonatomic, strong) UIButton* normalButton;
@property (nonatomic, strong) UIButton* zeroButton;
@property (nonatomic, copy)   NSArray* firstArray;
@property (nonatomic, weak) id<viewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
