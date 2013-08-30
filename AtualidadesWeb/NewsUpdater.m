//
//  NewsUpdater.m
//  AtualidadesWeb
//
//  Created by Alabê Duarte on 8/30/13.
//  Copyright (c) 2013 atualidadesweb. All rights reserved.
//

#import "NewsUpdater.h"
#import "News.h"
#import <RestKit/RestKit.h>

@implementation NewsUpdater

- (void)updateNews:(void (^)(NSArray *result)) success;
{
    RKObjectMapping *newsMapping = [RKObjectMapping mappingForClass:[News class]];
    [newsMapping addAttributeMappingsFromDictionary:@{
     @"id" : @"id",
     @"title" : @"title",
     @"subtitle" : @"subtitle",
     @"image" : @"image"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:newsMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://atualidadesweb.com.br/timeline.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        success([result array]);
    } failure:nil];
    
    [operation start];
}

@end
