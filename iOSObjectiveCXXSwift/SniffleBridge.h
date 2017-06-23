//
//  SniffleBridge.h
//  iOSObjectiveCXXSwift
//
//  Created by Steph on 6/10/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//

#ifndef SniffleBridge_h
#define SniffleBridge_h

#include "sniffle-interpreter/headers/interp.h"

expression * allocateSpriteList(expression * arglist, environment * env, environment * args);

expression * spriteWithSizeAndImage(expression * arglist, environment * env, environment * args);

expression * putOnScreenAtPoint(expression * arglist, environment * env, environment * args);

#endif /* SniffleBridge_h */
