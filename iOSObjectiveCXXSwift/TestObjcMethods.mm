//
//  TestObjcMethods.m
//  SwiftObjcCXXTest
//
//  Created by Steph on 6/9/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//

#import "TestObjcMethods.h"
#include <iostream>
#include "interpreter/headers/interp.h"

void dangerWillRobinson(int x){
    std::cout << "hi " << x << std::endl;
    [ObjcShell callBack:x];
}

/**
 create a move by skaction as an animation
 
 Sniffle:
 arg[0] : name of sound file
 arg[1] : integer(0/1) indicating whether or not to wait until the sound is complete the continue
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * makeSound(expression * arglist, environment * env, environment * args){
    expression *name, *wait;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    NSString *fileName;
    int toWait = 0;
    if(list->len != 2) {
        return NULL;
    }
    //get name of file
    name = evalAST((expression *)(iter->elem), env, args);
    //get wait
    wait = evalAST((expression *)(iter->elem), env, args);
    
    if(name != NULL && name->type == CONST_EXP) {
        fileName = @(name->data.str->s->c_str());
    }
    
    if(wait != NULL && wait->type == CONST_EXP) {
        toWait = wait->data.num;
    }
    
    SKAction * snd = [SKAction playSoundFileNamed:fileName waitForCompletion: toWait == 0 ? false : true];
    
    [actions addObject:snd];
    
    //clean up
    deleteExpression(name);
    deleteExpression(wait);
    
    //return next index
    return makeInt(nextActionInd++);
}

/**
 allocates room for x many sprites
 Sniffle arg[0] (SIZE): how many sprites should we allocated space for
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * allocateSpriteList(expression * arglist, environment * env, environment * args){
    expression * temp;
    //retreive underlying list struct
    slist * list = arglist->data.list;
    int size = 0;
    //check that we have the right number of args
    if(list->len != 1)
        // NULL is a valid sniffle exp and usually what we return in error
        return NULL;
    // evaluate the first thing in the list
    temp = evalAST((expression *)(list->head->elem), env, args);
    //check that we have the right type (types are found in lispinclude.h)
    //type definitions in datastructures & expressions
    //also make sure non null as null is a valid sniffle exp
    if(temp != NULL && temp->type == CONST_EXP){
        size = temp->data.num; // get the size
        if(size > 0){
            sprites = nil;
            sprites = [NSMutableArray arrayWithCapacity:size];
        }else{
            sprites = nil;
            sprites = [NSMutableArray arrayWithCapacity:0];
        }
        nextSpriteInd = 0;
    }
    
    //always have to delete the expressions we create and don't return.
    //we must delete nothing else, but must delete our temporary values.
    deleteExpression(temp);
    return NULL;
}

/**
 allocates room for x many textures
 
 see allocateSpriteList for more details
 Sniffle arg[0] (SIZE): how many sprites should we allocated space for
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * allocateTextureList(expression * arglist, environment * env, environment * args){
    expression * temp;
    slist * list = arglist->data.list;
    int size = 0;
    if(list->len != 1)
        return NULL;
    temp = evalAST((expression *)(list->head->elem), env, args);
    if(temp != NULL && temp->type == CONST_EXP){
        size = temp->data.num;
        if(size > 0){
            textures = nil;
            textures = [NSMutableArray arrayWithCapacity:size];
        }else{
            textures = nil;
            textures = [NSMutableArray arrayWithCapacity:0];
        }
        nextTexInd = 0;
    }
    
    //cleanup
    deleteExpression(temp);
    return NULL;
}

/**
 allocates room for x many animations
 
 see allocateSpriteList for more details
 Sniffle arg[0] (SIZE): how many sprites should we allocated space for
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * allocateActionsList(expression * arglist, environment * env, environment * args){
    expression * temp;
    slist * list = arglist->data.list;
    int size = 0;
    if(list->len != 1)
        return NULL;
    temp = evalAST((expression *)(list->head->elem), env, args);
    if(temp != NULL && temp->type == CONST_EXP){
        size = temp->data.num;
        if(size > 0){
            actions = nil;
            actions = [NSMutableArray arrayWithCapacity:size];
        }else{
            actions = nil;
            actions = [NSMutableArray arrayWithCapacity:0];
        }
        nextActionInd = 0;
    }

    //cleanup
    deleteExpression(temp);
    return NULL;
}

/**
 create a move by skaction as an animation
 
 Sniffle:
 arg[0] (dx): delta x position to move by
 arg[1] (dy): delta y position to move by
 arg[2] (duration in ms): duration of action in milliseconds
 return: index of animation in animations list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * moveByAnim(expression * arglist, environment * env, environment * args){
    expression * x, *y, *d;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float dx = 100, dy = 100, duration = 1;
    if(list->len != 3){
        return NULL;
    }
    //eval x
    x = evalAST((expression *)(iter->elem), env, args);
    //move along to next element in arguments
    iter = iter->next;
    //eval y
    y = evalAST((expression *)(iter->elem), env, args);
    //yada yada
    iter = iter->next;
    d = evalAST((expression *)(iter->elem), env, args);
    //set the values, casting to float from ints
    if(x != NULL && x->type == CONST_EXP){
        dx = (float)x->data.num;
    }
    if(y != NULL && y->type == CONST_EXP){
        dy = (float)y->data.num;
    }
    //duration is in ms
    if(d != NULL && d->type == CONST_EXP){
        duration = (float)(d->data.num)/1000.0f;
        //duration is non negative
        if(duration < 0){
            duration = 0;
        }
    }
    SKAction * anim = [SKAction moveBy:CGVectorMake(dy, dy) duration:duration];
    [actions addObject:anim];
    
    //clean everything up
    deleteExpression(x);
    deleteExpression(y);
    deleteExpression(d);
    
    //return the next index
    return makeInt(nextActionInd++);
}

/**
 create a sequence skaction as an animation
 
 Sniffle (var arg func):
 arg[i]: ith animation to run as a number representing the index in the animations list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * sequenceAction(expression * arglist, environment * env, environment * args){
    expression * x;
    slist * list = arglist->data.list;
    snode * iter;
    int action = 0;
    //where we'll shove things
    NSMutableArray * array;
    //create with enough space
    array = [NSMutableArray arrayWithCapacity:list->len];
    //loop over a slist pattern
    for(iter = list->head; iter != NULL; iter = iter->next){
        //evaluate the next argument
        x = evalAST((expression *)(iter->elem), env, args);
        if(x != NULL && x->type == CONST_EXP){
            action = x->data.num;
        }
        [array addObject:[actions objectAtIndex:action]];
        //clean up as we created this via eval ast
        deleteExpression(x);
    }
    
    SKAction * actn = [SKAction sequence:array];
    [actions addObject:actn];
    
    //return index
    return makeInt(nextActionInd++);
}

/**
 create a group skaction as an animation, will run all animations in parallel
 exactly like sequence only all args evaluated at once rather than as we need them
 
 Sniffle (var arg func):
 arg[i]: ith animation to run as a number representing the index in the animations list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * groupAction(expression * arglist, environment * env, environment * args){
    expression * x;
    slist * list = arglist->data.list, *evaled;
    snode * iter;
    int action = 0;
    NSMutableArray * array;
    //evaluate the whole arguments list.
    //note: we'll have to delete all the elems in this
    evaled = evalList(list, env, args);
    array = [NSMutableArray arrayWithCapacity:evaled->len];
    for(iter = evaled->head; iter != NULL; iter = iter->next){
        x = (expression *)(iter->elem);
        if(x != NULL && x->type == CONST_EXP){
            action = x->data.num;
        }
        [array addObject:[actions objectAtIndex:action]];
        //delete it as we created via an eval
        deleteExpression(x);
    }
    
    SKAction * actn = [SKAction group:array];
    [actions addObject:actn];
    //free the list
    freeList(evaled);
    
    //return index
    return makeInt(nextActionInd++);
}

/**
 create a move by skaction as an animation
 
 Sniffle:
 arg[0] (deltaSize): amount to scale by in thousandths (e.g. deltaSize = 1 means 1/1000 relative size)
 arg[1] (duration in ms): duration of action in milliseconds
 return: index of animation in animations list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * scaleAnim(expression * arglist, environment * env, environment * args){
    expression * x, *d;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float dx = 100, duration = 1;
    if(list->len != 2)
        return NULL;
    x = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    d = evalAST((expression *)(iter->elem), env, args);
    if(x != NULL && x->type == CONST_EXP){
        dx = (float)(x->data.num)/1000.0f;
        if(dx < 0){
            dx = 0;
        }
    }
    if(d != NULL && d->type == CONST_EXP){
        duration = (float)(d->data.num)/1000.0f;
        if(duration < 0){
            duration = 0;
        }
    }
    SKAction * anim = [SKAction scaleBy:dx duration:duration];
    [actions addObject:anim];
    deleteExpression(x);
    deleteExpression(d);
    return makeInt(nextActionInd++);
}

/**
 create a repeated animation
 
 Sniffle:
 arg[0] (animation): the animation index to repeat
 arg[1] (count): the number of times to repeat. -1 is infinity
 return: index of animation in animations list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * repeatAction(expression * arglist, environment * env, environment * args){
    expression * act, *times;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    int action = 0, time = -1;
    if(list->len != 2)
        return NULL;
    act = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    times = evalAST((expression *)(iter->elem), env, args);
    if(act != NULL && act->type == CONST_EXP){
        action = act->data.num;
        if(action < 0){
            action = 0;
        }
    }
    if(times != NULL && times->type == CONST_EXP){
        time = times->data.num;
        if(time < 0){
            time = -1;
        }
    }
    SKAction * actn, *source = [actions objectAtIndex:action];
    if(time == -1){
        NSLog(@"forever");
        actn = [SKAction repeatActionForever:source];
    }else{
        actn = [SKAction repeatAction:source count:time];
    }
    [actions addObject:actn];
    deleteExpression(act);
    deleteExpression(times);
    return makeInt(nextActionInd++);
}

/**
 run animation by index
 
 Sniffle:
 arg[0] (animation): the animation index to run
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * runAction(expression * arglist, environment * env, environment * args){
    expression * act, *node;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    int nindex = 0, aindex = 0;
    if(list->len != 2)
        return NULL;
    act = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    node = evalAST((expression *)(iter->elem), env, args);
    if(act != NULL && act->type == CONST_EXP){
        aindex = act->data.num;
        if(aindex < 0){
            aindex = 0;
        }
    }
    if(node != NULL && node->type == CONST_EXP){
        nindex = node->data.num;
        if(nindex < 0){
            nindex = 0;
        }
    }
    SKAction * a = [actions objectAtIndex:aindex];
    SKNode * n = [sprites objectAtIndex:nindex];
    [n runAction:a];
    deleteExpression(act);
    deleteExpression(node);
    return NULL;
}

/**
 create a rotate by angle skaction as an animation
 
 Sniffle:
 arg[0] (deltaSize): amount to scale by in degrees (e.g. deltaSize = 360 means 2*PI)
 arg[1] (duration in ms): duration of action in milliseconds
 return: index of animation in animations list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * rotateAnim(expression * arglist, environment * env, environment * args){
    expression * x, *d;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float dx = 100, duration = 1;
    if(list->len != 2)
        return NULL;
    x = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    d = evalAST((expression *)(iter->elem), env, args);
    if(x != NULL && x->type == CONST_EXP){
        dx = (float)(x->data.num)/180.0f*3.141592654f;
        if(dx < 0){
            dx = 0;
        }
    }
    if(d != NULL && d->type == CONST_EXP){
        duration = (float)(d->data.num)/1000.0f;
        if(duration < 0){
            duration = 0;
        }
    }
    SKAction * anim = [SKAction rotateByAngle:dx duration:duration];
    [actions addObject:anim];
    deleteExpression(x);
    deleteExpression(d);
    return makeInt(nextActionInd++);
}

/**
 create a sprite with a size and an image
 
 Sniffle:
 arg[0] (width): width of the sprite
 arg[1] (height): height of the sprite
 arg[2] (image): index of the image (texture)
 return: index of sprite in sprites list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * spriteWithSizeAndImage(expression * arglist, environment * env, environment * args){
    expression * w, *h, *image;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float width = 0, height = 0;
    int img = 0;
    if(list->len != 3)
        return NULL;
    w = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    h = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    image = evalAST((expression *)(iter->elem), env, args);
    if(w != NULL && w->type == CONST_EXP){
        width = (float)w->data.num;
        if(width < 0){
            width = 0;
        }
    }
    if(h != NULL && h->type == CONST_EXP){
        height = (float)h->data.num;
        if(height < 0){
            height = 0;
        }
    }
    if(image != NULL && image->type == CONST_EXP){
        img = image->data.num;
        if(img < 0){
            img = 0;
        }
    }
    SKTexture * tex = [textures objectAtIndex:img];
    SKSpriteNode * sprite = [[SKSpriteNode alloc] initWithTexture:tex color:[UIColor redColor] size:CGSizeMake(width, height)];
    [sprites addObject:sprite];
    deleteExpression(w);
    deleteExpression(h);
    deleteExpression(image);
    return makeInt(nextSpriteInd++);
}


/**
 create a texture from a source file
 
 Sniffle:
 arg[0] (imageName): the name of the image in the bundle
 return: index of texture in textures list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * textureFromImage(expression * arglist, environment * env, environment * args){
    expression *image;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    const char * loc = NULL;
    if(list->len != 1)
        return NULL;
    image = evalAST((expression *)(iter->elem), env, args);
    if(image != NULL && image->type == STR_EXP){
        loc = image->data.str->s->c_str();
    }
    SKTexture * tex = NULL;
    if(loc != NULL){
        NSString * both = [NSString stringWithCString:loc encoding:NSASCIIStringEncoding];
        tex = [SKTexture textureWithImageNamed:both];
    }
    [textures addObject:tex];
    deleteExpression(image);
    return makeInt(nextTexInd++);
}

/**
 put an actor/sprite (skspritenode) on screen at a certain point
 
 Sniffle:
 arg[0] (sprite): the index of the sprite to put somewhere
 arg[1] (x): the x coordinate to put the image at
 arg[2] (y): the y coordinate to put the image at
 return: index of texture in textures list
 
 @param arglist The list of arguments passed into the Sniffle invocation of this function
 @param env The environment that this was called in
 @param args The environment of the innermost lambda function or NULL
 */
expression * putOnScreenAtPoint(expression * arglist, environment * env, environment * args){
    expression * sprite, *x, *y;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float xp = 0, yp = 0;
    int index = 0;
    if(list->len != 3)
        return NULL;
    sprite = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    x = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    y = evalAST((expression *)(iter->elem), env, args);
    if(sprite != NULL && sprite->type == CONST_EXP){
        index = sprite->data.num;
        if(index < 0){
            index = 0;
        }
    }
    if(x != NULL && x->type == CONST_EXP){
        xp = (float)x->data.num;
    }
    if(y != NULL && y->type == CONST_EXP){
        yp = (float)y->data.num;
    }
    SKSpriteNode * spr = [sprites objectAtIndex:index];
    [spr removeFromParent];
    [spr setPosition:CGPointMake(xp, yp)];
    [globalScene addChild:spr];
    deleteExpression(sprite);
    deleteExpression(x);
    deleteExpression(y);
    return NULL;
}

/**
 runs a sniffle string with our added objective c functions
 
 @param data The raw ascii source code to run
 @param len The length of data
 */
void runSniffleString(const char * data, std::size_t len){
    environment * ENV = createEnv();
    (*ENV)["SpriteAlloc"] = makeCFunc(&allocateSpriteList);
    (*ENV)["TextureAlloc"] = makeCFunc(&allocateTextureList);
    (*ENV)["ActionAlloc"] = makeCFunc(&allocateActionsList);
    (*ENV)["Sprite"] = makeCFunc(&spriteWithSizeAndImage);
    (*ENV)["Texture"] = makeCFunc(&textureFromImage);

    (*ENV)["sound"] = makeCFunc(&makeSound);
    (*ENV)["sequence"] = makeCFunc(&sequenceAction);
    (*ENV)["group"] = makeCFunc(&groupAction);
    (*ENV)["moveBy"] = makeCFunc(&moveByAnim);
    (*ENV)["scale"] = makeCFunc(&scaleAnim);
    (*ENV)["rotate"] = makeCFunc(&rotateAnim);
    (*ENV)["repeat"] = makeCFunc(&repeatAction);
    (*ENV)["run"] = makeCFunc(&runAction);
    
    (*ENV)["addChild"] = makeCFunc(&putOnScreenAtPoint);

    expression * prog = parseList((char*)data, len);
    runProgram(prog, ENV);
    deleteExpression(prog);
    deleteEnv(ENV);
}

@implementation ObjcShell

/**
badly named function that's running some basic sniffle for the current demo.
 */
+ (void) addSprite:(SKScene *)scene{
    globalScene = scene;
    [ObjcShell runProgram:@"(SpriteAlloc 10) (TextureAlloc 10) (ActionAlloc 11) (set mysound (sound \"GymnopedieNo1KevinMacleod.mp3\" 1)) (set anim1 (repeat (sequence (moveBy 50 -70 1000) (scale 1100 500) (rotate 360 500)) 5)) (set anim2 (repeat (group (moveBy 50 -70 1000) (scale 750 500) (rotate 360 500)) 10)) (set lowcat (Texture \"lowpolycat.png\")) (set sprite1 (Sprite 100 100 lowcat)) (set sprite2 (Sprite 200 300 lowcat)) (addChild sprite2 100 0)(addChild sprite1 -100 200) (run anim1 sprite1) (run mysound sprite2) (run anim2 sprite2)"];
    /*SKSpriteNode * sprite = [[SKSpriteNode alloc] initWithTexture:NULL color:[UIColor redColor] size:CGSizeMake(100, 100)];
    [sprite setPosition:CGPointMake(10, 10)];
    [scene addChild:sprite];*/

}

/**
 run a sniffle program stored in an NSString
 */
+ (void) runProgram:(NSString *) program{
    runSniffleString([program cStringUsingEncoding:NSASCIIStringEncoding], [program length]);
}

//test function
+ (void) callWithInt:(int)x{
    printf("WHOA %i\n",x);
    dangerWillRobinson(x);
    [ObjcShell runProgram:@"(quote (+ 1 2 3 4 5 6 7 8 9 10)) (begin (set f (lambda (x) (if (= x 0) 1 (* x (f (- x 1)))))) (f 5))"];

}

//test function
+ (void) callBack:(int)x{
    printf("Double WHOA %i\n",x);
}

@end
