//
//  CNCodeTextView.m
//  CNHighlightr
//
//  Created by 孟瑞瑞 on 2020/12/25.
//

#import "CNCodeTextView.h"
#import "Highlightr.h"
#import "CodeAttributedString.h"


@interface CNCodeTextView ()

@property(nonatomic,copy) CodeAttributedString *codeTextStorage;

@property (nonatomic, strong) CNCodeNumberLayoutManager *codeTextLayoutManager;


@end

@implementation CNCodeTextView

- (id)initWithFrame:(CGRect) frame {
    
    self.codeTextStorage = [[CodeAttributedString alloc] init];
    
    self.codeTextLayoutManager = [[CNCodeNumberLayoutManager alloc] init];
    self.codeTextLayoutManager.width = 36.0;
    self.codeTextLayoutManager.codeNumberAlignment = CNCodeNumberAlignmentRight;
    [self.codeTextStorage addLayoutManager:self.codeTextLayoutManager];
    NSTextContainer* textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    //  Wrap text to the text view's frame
    textContainer.widthTracksTextView = YES;
    
    //  Exclude the line number gutter from the display area available for text display.
    textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, self.codeTextLayoutManager.width, CGFLOAT_MAX)]];
    
    [self.codeTextLayoutManager addTextContainer:textContainer];
    
    
    if ((self = [super initWithFrame:frame textContainer:textContainer])) {
        self.contentMode = UIViewContentModeRedraw; // cause drawRect: to be called on frame resizing and device rotation
        
        //  I'm finding that this text view is not behaving properly when typing into a new line at the end of the body
        //  of text.  The cursor is positioned inward, and then jumps back to the proper position when a character is
        //  typed.  I'm sure this has something to do with the view's typingAttributes or one of the delegate methods.
        
        //self.typingAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0],
        //                          NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]};
        _lineNumberBackgroundColor = [UIColor grayColor];
        _lineNumberBorderColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    if (!self.lineNumberHidden) {
        //  Drag the line number gutter background.  The line numbers them selves are drawn by LineNumberLayoutManager.
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect bounds = self.bounds;
        
        CGContextSetFillColorWithColor(context, _lineNumberBackgroundColor.CGColor);
        CGContextFillRect(context, CGRectMake(bounds.origin.x, bounds.origin.y, self.codeTextLayoutManager.width, bounds.size.height));
        
        CGContextSetStrokeColorWithColor(context, _lineNumberBorderColor.CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGContextStrokeRect(context, CGRectMake(bounds.origin.x + self.codeTextLayoutManager.width - 0.5, bounds.origin.y, 0.5, CGRectGetHeight(bounds)));
        
        [super drawRect:rect];
    }
}

- (UIFont *)lineNumberFont {
    if (self.lineNumberHidden) {
        return nil;
    }
    CNCodeNumberLayoutManager* lm = (CNCodeNumberLayoutManager*) self.layoutManager;
    return lm.lineNumberFont;
}

- (void)setLineNumberFont:(UIFont *)lineNumberFont {
    if (self.lineNumberHidden) {
        return;
    }
    CNCodeNumberLayoutManager* lm = (CNCodeNumberLayoutManager*) self.layoutManager;
    if (![lm.lineNumberFont isEqual:lineNumberFont]) {
        lm.lineNumberFont = lineNumberFont;
        [self setNeedsDisplay];
    }
}

- (UIColor *)lineNumberTextColor {
    if (self.lineNumberHidden) {
        return nil;
    }
    CNCodeNumberLayoutManager* lm = (CNCodeNumberLayoutManager*) self.layoutManager;
    return lm.lineNumberTextColor;
}

- (void)setLineNumberTextColor:(UIColor *)lineNumberTextColor {
    if (self.lineNumberHidden) {
        return;
    }
    CNCodeNumberLayoutManager* lm = (CNCodeNumberLayoutManager*) self.layoutManager;
    if (![lm.lineNumberTextColor isEqual:lineNumberTextColor]) {
        lm.lineNumberTextColor = lineNumberTextColor;
        [self setNeedsDisplay];
    }
}

- (void)setLineNumberBackgroundColor:(UIColor *)lineNumberBackgroundColor {
    if (![_lineNumberBackgroundColor isEqual:lineNumberBackgroundColor]) {
        _lineNumberBackgroundColor = lineNumberBackgroundColor;
        [self setNeedsDisplay];
    }
}


- (void)setLineNumberBorderColor:(UIColor *)lineNumberBorderColor {
    if (![_lineNumberBorderColor isEqual:lineNumberBorderColor]) {
        _lineNumberBorderColor = lineNumberBorderColor;
        [self setNeedsDisplay];
    }
}

-(void)setThemeName:(NSString *)themeName{
    if (![_themeName isEqual:themeName]) {
        _themeName = themeName;
        [self.codeTextStorage.highlightr setThemeTo:themeName];
        [self setNeedsDisplay];
    }
}

-(void)setLanguage:(NSString *)language
{
    if (![_language isEqual:language]) {
        _language = language;
        self.codeTextStorage.language = language;
        [self setNeedsDisplay];
    }
}

-(void)setLineSpacing:(CGFloat)lineSpacing{
    if (_lineSpacing != lineSpacing) {
        _lineSpacing = lineSpacing;
        self.codeTextStorage.lineSpacing = lineSpacing;
        [self setNeedsDisplay];
    }
}

-(void)setCodeFont:(UIFont *)codeFont{
    if (![_codeFont isEqual:codeFont]) {
        _codeFont = codeFont;
        self.codeTextStorage.font = codeFont;
        [self setNeedsDisplay];
    }
}

-(void)setLineNumberHidden:(BOOL)lineNumberHidden{
    if (_lineNumberHidden != lineNumberHidden) {
        _lineNumberHidden = lineNumberHidden;
        self.lineNumberHidden = lineNumberHidden;
        self.textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, 0.0, CGFLOAT_MAX)]];
        self.codeTextLayoutManager.width = 0;
        [self setNeedsDisplay];
    }
}

- (void)setLineNumberWidth:(CGFloat)lineNumberWidth{
    CNCodeNumberLayoutManager* lm = (CNCodeNumberLayoutManager*) self.layoutManager;
    if (lm.width != lineNumberWidth) {
        lm.width = lineNumberWidth;
        self.textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, lineNumberWidth, CGFLOAT_MAX)]];
        [self setNeedsDisplay];
    }
}

-(void)setLineNumberAlignment:(CNCodeNumberAlignment)lineNumberAlignment{
    CNCodeNumberLayoutManager* lm = (CNCodeNumberLayoutManager*) self.layoutManager;
    if (lm.codeNumberAlignment != lineNumberAlignment) {
        lm.codeNumberAlignment = lineNumberAlignment;
        [self setNeedsDisplay];
    }
}

@end
