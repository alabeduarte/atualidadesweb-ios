//
//  ViewController.m
//  AtualidadesWeb
//
//  Created by Alabê Duarte on 8/28/13.
//  Copyright (c) 2013 atualidadesweb. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "ViewController.h"
#import <RestKit/RestKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    RKObjectMapping *newsMapping = [RKObjectMapping mappingForClass:[News class]];
    [newsMapping addAttributeMappingsFromDictionary:@{
     @"id" : @"id",
     @"title" : @"title",
     @"subtitle" : @"subtitle",
     @"image" : @"image"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:newsMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/timeline.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        self.news = [result array];
        [self.tableView reloadData];
    } failure:nil];
    
    [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"News"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"News"];
    }
    
    cell.textLabel.text = self.news[indexPath.row][@"title"];    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // select row at index
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
