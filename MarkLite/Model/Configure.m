//
//  Configure.m
//  MarkLite
//
//  Created by zhubch on 11/9/15.
//  Copyright © 2015 zhubch. All rights reserved.
//

#import "Configure.h"

@implementation Configure

+ (instancetype)sharedConfigure
{
    static Configure *conf = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *path = [[NSString documentPath] stringByAppendingPathComponent:@"Configure.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            conf = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }else{
            conf = [[self alloc]init];
            conf.keyboardAssist = YES;
        }
    });
    return conf;
}

- (BOOL)saveToFile
{
    NSString *path = [[NSString documentPath] stringByAppendingPathComponent:@"Configure.plist"];
    
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.fileHisory forKey:@"fileHisory"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.fileHisory=[[aDecoder decodeObjectForKey:@"fileHisory"] mutableCopy];
        if (self.fileHisory == nil) {
            self.fileHisory = [NSMutableArray array];
        }
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.fileHisory = [NSMutableArray array];
    }
    return self;
}

- (NSString *)style
{
    if (_style.length == 0) {
        return @"GitHub2";
    }
    return _style;
}

@end