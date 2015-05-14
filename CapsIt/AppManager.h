//
//  AppManager.h
//  CapsIt
//
//  Created by Hüseyin Kabil on 09/07/14.
//  Copyright (c) 2014 Hüseyin Kabil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject


@property(nonatomic, retain) NSDictionary *dictWords;
@property(nonatomic, retain) NSString *lng;

+(AppManager *)sharedManager;
-(NSString *)translate:(NSString *)key;
@end
