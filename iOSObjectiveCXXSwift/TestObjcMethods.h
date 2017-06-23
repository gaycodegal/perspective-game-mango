//
//  TestObjcMethods.h
//  SwiftObjcCXXTest
//
//  Created by Steph on 6/9/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#ifndef TestObjcMethods_h
#define TestObjcMethods_h


static NSMutableArray * sprites = nil;
static NSMutableArray * animations = nil;
static SKScene * globalScene = nil;
static int nextSpriteInd = 0;
static int nextTexInd = 0;
static int nextAnimInd = 0;
static NSMutableArray * textures = nil;

@interface ObjcShell : NSObject
{
}

//set
+ (void) callWithInt:(int)x;
+ (void) callBack:(int)x;
+ (void) addSprite:(SKScene *)scene;
@end

#endif /* TestObjcMethods_h */
