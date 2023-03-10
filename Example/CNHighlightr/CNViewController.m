//
//  CNViewController.m
//  CNHighlightr
//
//  Created by mengruirui on 12/03/2020.
//  Copyright (c) 2020 mengruirui. All rights reserved.
//

#import "CNViewController.h"
#import <CNHighlightr/CNCodeTextView.h>
@interface CNViewController ()

@end

@implementation CNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSString *code = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sampleCode" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    
    CNCodeTextView *codeView = [[CNCodeTextView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:codeView];
    codeView.text = code;
    codeView.language = @"swift";
    codeView.themeName = @"xcode";
    codeView.codeFont = [UIFont systemFontOfSize:14];
    //行高
    codeView.lineSpacing = 3;
    //是否可以编辑
    [codeView setEditable:NO];
    //长按是否有选择弹窗
    [codeView setSelectable:NO];

    codeView.lineNumberHidden = NO;
    codeView.lineNumberBackgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
    codeView.lineNumberTextColor = [UIColor colorWithRed:153/255.0 green:154/255.0 blue:170/255.0 alpha:1.0];
    codeView.lineNumberBorderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
    codeView.lineNumberFont = [UIFont systemFontOfSize:14];
    codeView.lineNumberWidth = 40;
    codeView.lineNumberAlignment = CNCodeNumberAlignmentCenter;
}


@end
