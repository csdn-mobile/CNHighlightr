//
//  HTMLUtils.h
//  HighlightrObjC
//
//  Created by 孟瑞瑞 on 2020/12/25.
//

#import <Foundation/Foundation.h>

@interface HTMLUtils : NSObject

@property(class,nonatomic,strong,readonly) NSDictionary<NSString*,NSString*> *characterEntities;

+ (NSString *)decode:(NSString *)entity;

@end
