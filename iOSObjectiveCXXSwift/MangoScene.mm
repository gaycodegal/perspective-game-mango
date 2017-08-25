//
//  MangoScene.m
//  iOSObjectiveCXXSwift
//
//  Created by Steph on 7/14/17.
//  Copyright © 2017 Steph Oro. All rights reserved.
//

#import "MangoScene.h"

@implementation MangoScene

-(id)init{
    self = [super init];
    return self;
}

-(void)loadSceneWithName:(NSString *)name{
    if(ENV == NULL)
        ENV = (environment *)createMangoEnvironment();
    NSString* path = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:@"lisp"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    [self runString:content];
    [self triggerEvent:@"SCENE_LOAD"];
}

-(void)runString:(NSString *)program{
    if(ENV == NULL)
        return;
    expression * prog = parseList((char*)[program cStringUsingEncoding:NSASCIIStringEncoding], [program length]);
    runProgram(prog, ENV);
    deleteExpression(prog);
}

-(void)triggerEvent:(NSString *)event{
    if(ENV == NULL)
        return;
    char * cevent = (char *)[event cStringUsingEncoding:NSASCIIStringEncoding];
    environmentIterator it = ENV->find(cevent);
    if(it != ENV->end()){
        expression * prog = it->second;
        runProgram(prog, ENV);
    }
}

@end
