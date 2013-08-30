//
//  NewsUpdater.h
//  AtualidadesWeb
//
//  Created by Alabê Duarte on 8/30/13.
//  Copyright (c) 2013 atualidadesweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface NewsUpdater : NSObject
- (void)updateNews:(void (^)(NSArray *result)) success;
@end
