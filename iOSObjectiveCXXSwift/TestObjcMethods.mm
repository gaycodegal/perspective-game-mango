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

expression * allocateSpriteList(expression * arglist, environment * env, environment * args){
    expression * temp;
    slist * list = arglist->data.list;
    int size = 0;
    if(list->len != 1)
        return NULL;
    temp = evalAST((expression *)(list->head->elem), env, args);
    if(temp->type == CONST_EXP){
        size = temp->data.num;
        if(size > 0){
            sprites = nil;
            sprites = [NSMutableArray arrayWithCapacity:size];
        }else{
            sprites = nil;
            sprites = [NSMutableArray arrayWithCapacity:0];
        }
        nextSpriteInd = 0;
    }
    
    deleteExpression(temp);
    return NULL;
}

expression * allocateTextureList(expression * arglist, environment * env, environment * args){
    expression * temp;
    slist * list = arglist->data.list;
    int size = 0;
    if(list->len != 1)
        return NULL;
    temp = evalAST((expression *)(list->head->elem), env, args);
    if(temp->type == CONST_EXP){
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
    
    deleteExpression(temp);
    return NULL;
}

expression * allocateAnimationList(expression * arglist, environment * env, environment * args){
    expression * temp;
    slist * list = arglist->data.list;
    int size = 0;
    if(list->len != 1)
        return NULL;
    temp = evalAST((expression *)(list->head->elem), env, args);
    if(temp->type == CONST_EXP){
        size = temp->data.num;
        if(size > 0){
            animations = nil;
            animations = [NSMutableArray arrayWithCapacity:size];
        }else{
            animations = nil;
            animations = [NSMutableArray arrayWithCapacity:0];
        }
        nextAnimInd = 0;
    }

    deleteExpression(temp);
    return NULL;
}


expression * moveByAnim(expression * arglist, environment * env, environment * args){
    expression * x, *y, *d;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float dx = 100, dy = 100, duration = 1;
    if(list->len != 3){
        return NULL;
    }
    x = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    y = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    d = evalAST((expression *)(iter->elem), env, args);
    if(x->type == CONST_EXP){
        dx = (float)x->data.num;
    }
    if(y->type == CONST_EXP){
        dy = (float)y->data.num;
    }
    if(d->type == CONST_EXP){
        duration = (float)(d->data.num)/1000.0f;
        if(duration < 0){
            duration = 0;
        }
    }
    SKAction * anim = [SKAction moveBy:CGVectorMake(dy, dy) duration:duration];
    [animations addObject:anim];
    deleteExpression(x);
    deleteExpression(y);
    deleteExpression(d);
    return makeInt(nextAnimInd++);
}

expression * sequenceAnim(expression * arglist, environment * env, environment * args){
    expression * x;
    slist * list = arglist->data.list;
    snode * iter;
    int animation = 0;
    NSMutableArray * array;
    //evaled = evalList(list, env, args);
    array = [NSMutableArray arrayWithCapacity:list->len];
    int count = 0;
    for(iter = list->head; iter != NULL; iter = iter->next){
        x = evalAST((expression *)(iter->elem), env, args);
        if(x != NULL && x->type == CONST_EXP){
            animation = x->data.num;
        }
        [array addObject:[animations objectAtIndex:animation]];
        deleteExpression(x);
    }
    
    SKAction * anim = [SKAction sequence:array];
    [animations addObject:anim];
    return makeInt(nextAnimInd++);
}

expression * groupAnim(expression * arglist, environment * env, environment * args){
    expression * x;
    slist * list = arglist->data.list, *evaled;
    snode * iter;
    int animation = 0;
    NSMutableArray * array;
    evaled = evalList(list, env, args);
    array = [NSMutableArray arrayWithCapacity:evaled->len];
    for(iter = evaled->head; iter != NULL; iter = iter->next){
        x = (expression *)(iter->elem);
        if(x != NULL && x->type == CONST_EXP){
            animation = x->data.num;
        }
        [array addObject:[animations objectAtIndex:animation]];
        deleteExpression(x);
    }
    
    SKAction * anim = [SKAction group:array];
    [animations addObject:anim];
    freeList(evaled);
    return makeInt(nextAnimInd++);
}

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
    if(x->type == CONST_EXP){
        dx = (float)(x->data.num)/1000.0f;
        if(dx < 0){
            dx = 0;
        }
    }
    if(d->type == CONST_EXP){
        duration = (float)(d->data.num)/1000.0f;
        if(duration < 0){
            duration = 0;
        }
    }
    SKAction * anim = [SKAction scaleBy:dx duration:duration];
    [animations addObject:anim];
    deleteExpression(x);
    deleteExpression(d);
    return makeInt(nextAnimInd++);
}

expression * repeatAnim(expression * arglist, environment * env, environment * args){
    expression * act, *times;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    int action = 0, time = -1;
    if(list->len != 2)
        return NULL;
    act = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    times = evalAST((expression *)(iter->elem), env, args);
    if(act->type == CONST_EXP){
        action = act->data.num;
        if(action < 0){
            action = 0;
        }
    }
    if(times->type == CONST_EXP){
        time = times->data.num;
        if(time < 0){
            time = -1;
        }
    }
    SKAction * anim, *source = [animations objectAtIndex:action];
    if(time == -1){
        NSLog(@"forever");
        anim = [SKAction repeatActionForever:source];
    }else{
        anim = [SKAction repeatAction:source count:time];
    }
    [animations addObject:anim];
    deleteExpression(act);
    deleteExpression(times);
    return makeInt(nextAnimInd++);
}

expression * runAnim(expression * arglist, environment * env, environment * args){
    expression * anim, *node;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    int nindex = 0, aindex = 0;
    if(list->len != 2)
        return NULL;
    anim = evalAST((expression *)(iter->elem), env, args);
    iter = iter->next;
    node = evalAST((expression *)(iter->elem), env, args);
    if(anim->type == CONST_EXP){
        aindex = anim->data.num;
        if(aindex < 0){
            aindex = 0;
        }
    }
    if(node->type == CONST_EXP){
        nindex = node->data.num;
        if(nindex < 0){
            nindex = 0;
        }
    }
    SKAction * a = [animations objectAtIndex:aindex];
    SKNode * n = [sprites objectAtIndex:nindex];
    [n runAction:a];
    deleteExpression(anim);
    deleteExpression(node);
    return NULL;
}

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
    if(x->type == CONST_EXP){
        dx = (float)(x->data.num)/180.0f*3.141592654f;
        if(dx < 0){
            dx = 0;
        }
    }
    if(d->type == CONST_EXP){
        duration = (float)(d->data.num)/1000.0f;
        if(duration < 0){
            duration = 0;
        }
    }
    SKAction * anim = [SKAction rotateByAngle:dx duration:duration];
    [animations addObject:anim];
    deleteExpression(x);
    deleteExpression(d);
    return makeInt(nextAnimInd++);
}

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
    if(w->type == CONST_EXP){
        width = (float)w->data.num;
        if(width < 0){
            width = 0;
        }
    }
    if(h->type == CONST_EXP){
        height = (float)h->data.num;
        if(height < 0){
            height = 0;
        }
    }
    if(image->type == CONST_EXP){
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

expression * textureFromImage(expression * arglist, environment * env, environment * args){
    expression *image;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    const char * loc = NULL;
    if(list->len != 1)
        return NULL;
    image = evalAST((expression *)(iter->elem), env, args);
    if(image->type == STR_EXP){
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
    if(sprite->type == CONST_EXP){
        index = sprite->data.num;
        if(index < 0){
            index = 0;
        }
    }
    if(x->type == CONST_EXP){
        xp = (float)x->data.num;
    }
    if(y->type == CONST_EXP){
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

void runSniffleString(const char * data, std::size_t len){
    environment * ENV = createEnv();
    (*ENV)["SpriteAlloc"] = makeCFunc(&allocateSpriteList);
    (*ENV)["TextureAlloc"] = makeCFunc(&allocateTextureList);
    (*ENV)["AnimationAlloc"] = makeCFunc(&allocateAnimationList);
    (*ENV)["Sprite"] = makeCFunc(&spriteWithSizeAndImage);
    (*ENV)["Texture"] = makeCFunc(&textureFromImage);

    (*ENV)["sequence"] = makeCFunc(&sequenceAnim);
    (*ENV)["group"] = makeCFunc(&groupAnim);
    (*ENV)["moveBy"] = makeCFunc(&moveByAnim);
    (*ENV)["scale"] = makeCFunc(&scaleAnim);
    (*ENV)["rotate"] = makeCFunc(&rotateAnim);
    (*ENV)["repeat"] = makeCFunc(&repeatAnim);
    (*ENV)["run"] = makeCFunc(&runAnim);
    
    (*ENV)["addChild"] = makeCFunc(&putOnScreenAtPoint);

    expression * prog = parseList((char*)data, len);
    runProgram(prog, ENV);
    deleteExpression(prog);
    deleteEnv(ENV);
}

@implementation ObjcShell

+ (void) addSprite:(SKScene *)scene{
    globalScene = scene;
    [ObjcShell runProgram:@"(SpriteAlloc 10) (TextureAlloc 10) (AnimationAlloc 10) (set anim1 (repeat (sequence (moveBy 50 -70 1000) (scale 1100 500) (rotate 360 500)) 5)) (set anim2 (repeat (group (moveBy 50 -70 1000) (scale 750 500) (rotate 360 500)) 10)) (set lowcat (Texture \"lowpolycat.png\")) (set sprite1 (Sprite 100 100 lowcat)) (set sprite2 (Sprite 200 300 lowcat)) (addChild sprite2 100 0)(addChild sprite1 -100 200) (run anim1 sprite1) (run anim2 sprite2)"];
    /*SKSpriteNode * sprite = [[SKSpriteNode alloc] initWithTexture:NULL color:[UIColor redColor] size:CGSizeMake(100, 100)];
    [sprite setPosition:CGPointMake(10, 10)];
    [scene addChild:sprite];*/

}

+ (void) runProgram:(NSString *) program{
    runSniffleString([program cStringUsingEncoding:NSASCIIStringEncoding], [program length]);
}

+ (void) callWithInt:(int)x{
    printf("WHOA %i\n",x);
    dangerWillRobinson(x);
    [ObjcShell runProgram:@"(quote (+ 1 2 3 4 5 6 7 8 9 10)) (begin (set f (lambda (x) (if (= x 0) 1 (* x (f (- x 1)))))) (f 5))"];

}

+ (void) callBack:(int)x{
    printf("Double WHOA %i\n",x);
}

@end
