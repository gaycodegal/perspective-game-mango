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

expression * spriteWithSizeAndImage(expression * arglist, environment * env, environment * args){
    expression * w, *h, *image;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    float width = 0, height = 0;
    int index = nextSpriteInd++, img = 0;
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
        height = (float)w->data.num;
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
    [sprites setObject:sprite atIndexedSubscript:index];
    deleteExpression(w);
    deleteExpression(h);
    deleteExpression(image);
    return makeInt(index);
}

expression * textureFromImage(expression * arglist, environment * env, environment * args){
    expression *image;
    slist * list = arglist->data.list;
    snode * iter = list->head;
    int index = nextTexInd++;
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
    [textures setObject:tex atIndexedSubscript:index];
    deleteExpression(image);
    return makeInt(index);
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
    
    (*ENV)["addChild"] = makeCFunc(&putOnScreenAtPoint);

    expression * prog = parseList((char*)data, len);
    runProgram(prog, ENV);
    deleteExpression(prog);
    deleteEnv(ENV);
}

@implementation ObjcShell

+ (void) addSprite:(SKScene *)scene{
    globalScene = scene;
    [ObjcShell runProgram:@"(SpriteAlloc 10) (TextureAlloc 10) (set lowcat (Texture \"lowpolycat.png\")) (set sprite1 (Sprite 100 100 lowcat)) (set sprite2 (Sprite 200 300 lowcat)) (addChild sprite2 100 0)(addChild sprite1 -100 200)"];
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
