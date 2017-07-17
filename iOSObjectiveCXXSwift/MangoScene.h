//
//  MangoScene.h
//  iOSObjectiveCXXSwift
//
//  Created by Steph on 7/14/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//
#ifndef MangoScene_h
#define MangoScene_h

#import <Foundation/Foundation.h>
#import "TestObjcMethods.h"
#include "interpreter/headers/interp.h"

@interface MangoScene : NSObject{
    environment * ENV;
    
}
-(void)loadSceneWithName:(NSString *)name;
-(void)runString:(NSString *)program;
-(void)triggerEvent:(NSString *)event;

@end

#endif
