//
//  AppManager.m
//  CapsIt
//
//  Created by Hüseyin Kabil on 09/07/14.
//  Copyright (c) 2014 Hüseyin Kabil. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (AppManager *)sharedManager
{
    static AppManager *sharedManager;
    
    @synchronized(self)
    {
        if (!sharedManager){
            sharedManager = [[AppManager alloc] init];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Türkçe", @"tr",
                                 @"English", @"en",
                                 nil];
            
            sharedManager.lng=@"";
            sharedManager.dictWords=dic;
        }
        return sharedManager;
    }
}

-(NSString *)translate:(NSString *)key{
    if([_lng isEqualToString:@"tr"])
        return key;
    else if ([_dictWords objectForKey:key])
        return [_dictWords objectForKey:key];
    else
        return key;
}
@end
