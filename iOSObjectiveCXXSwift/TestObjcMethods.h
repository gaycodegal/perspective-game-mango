//
//  TestObjcMethods.h
//  SwiftObjcCXXTest
//
//  Created by Steph on 6/9/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//
#ifndef TestObjcMethods_h
#define TestObjcMethods_h
#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@class MangoScene;
void * createMangoEnvironment();

static NSMutableArray * sprites = nil;
static NSMutableArray * actions = nil;
static SKScene * globalScene = nil;
static int nextSpriteInd = 0;
static int nextTexInd = 0;
static int nextActionInd = 0;
static NSMutableArray * textures = nil;

@interface ObjcShell : NSObject
{
    
}

//set
+ (void) callWithInt:(int)x;
+ (MangoScene *) getMainScene;
+ (void) callBack:(int)x;
+ (void) addSprite:(SKScene *)scene;

+ (void) loadSceneWithName:(NSString *)name;
+ (void) runString:(NSString *)program;
+ (void) triggerEvent:(NSString *)event;

@end

#endif /* TestObjcMethods_h */
