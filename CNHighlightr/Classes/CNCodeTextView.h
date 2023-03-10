//
//  CNCodeTextView.h
//  CNHighlightr
//
//  Created by 孟瑞瑞 on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import "CNCodeNumberLayoutManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface CNCodeTextView : UITextView

/// Defaults to system font, 10pt.
@property (nonatomic) UIFont *lineNumberFont;

/// Defaults to gray.
@property (nonatomic) UIColor *lineNumberBackgroundColor;

/// Defaults to dark gray.
@property (nonatomic) UIColor *lineNumberBorderColor;

/// Defaults to white.
@property (nonatomic) UIColor *lineNumberTextColor;

/// Defaults to system font, 10pt.
@property (nonatomic, assign) CGFloat lineNumberWidth;

/// Defaults to CNCodeNumberAlignmentRight.
@property (nonatomic, assign) CNCodeNumberAlignment lineNumberAlignment;

@property (nonatomic, copy) NSString *themeName;

@property (nonatomic, copy) NSString *language;

@property (nonatomic, assign) CGFloat lineSpacing;

@property (nonatomic, strong) UIFont *codeFont;

@property (nonatomic, assign) BOOL lineNumberHidden;

- (id)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
