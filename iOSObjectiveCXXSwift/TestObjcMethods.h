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
static NSMutableArray * buttons = nil;
static SKScene * globalScene = nil;
static int nextButtonInd = 0;
static int nextSpriteInd = 0;
static int nextTexInd = 0;
static int nextActionInd = 0;
static NSMutableArray * textures = nil;
typedef void (^IntToVoid)(UIControlEvents);
@interface MangoUIButton : UIButton {
    IntToVoid _actionBlock;
    IntToVoid _deleteBlock;
}
-(void)setBlocks:(IntToVoid)action withDeleteMe:(IntToVoid)deleteMe;
-(void)bindToEvent:(UIControlEvents)event;
-(void)callDeleteMe;
@end

@interface ObjcShell : NSObject
{
    
}
+(void)setView:(UIView*)view;
//set
+ (void) callWithInt:(int)x;
+ (MangoScene *) getMainScene;
+ (void) callBack:(int)x;
+ (void) setScene:(SKScene *)scene;

+ (void) loadSceneWithName:(NSString *)name;
+ (void) runString:(NSString *)program;
+ (void) triggerEvent:(NSString *)event;

@end

#endif /* TestObjcMethods_h */
