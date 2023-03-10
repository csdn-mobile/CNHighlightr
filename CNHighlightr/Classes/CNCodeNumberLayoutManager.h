//
//  CNCodeNumberLayoutManager.h
//  CNHighlightr
//
//  Created by 孟瑞瑞 on 2020/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 行号对齐方式
typedef NS_ENUM(NSUInteger, CNCodeNumberAlignment) {
    CNCodeNumberAlignmentCenter, //居中
    CNCodeNumberAlignmentLeft,   //居左
    CNCodeNumberAlignmentRight,  //居右
};

@interface CNCodeNumberLayoutManager : NSLayoutManager

/// Defaults to system font, 10pt.
@property (nonatomic) UIFont *lineNumberFont;

/// Defaults to white.
@property (nonatomic) UIColor *lineNumberTextColor;

@property (nonatomic, assign) CGFloat width;

/// Defaults to CNCodeNumberAlignmentRight.
@property (nonatomic, assign) CNCodeNumberAlignment codeNumberAlignment;

@end

NS_ASSUME_NONNULL_END
