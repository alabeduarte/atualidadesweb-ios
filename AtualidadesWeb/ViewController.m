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
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setHidden: YES];
    
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
        self.news = [result array];
        
        [self.tableView setHidden: NO];
        [self.tableView reloadData];
        
        self.headerItem.title = @"Atualidades | Web";
    } failure:nil];
    
    [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *NewsIdentifier = @"News";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NewsIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: NewsIdentifier];
    } else {
    }
    
    News *aNews = [self.news objectAtIndex: indexPath.row];
    cell.textLabel.text = aNews.title;
    cell.detailTextLabel.text = aNews.subtitle;

    NSURL *image = [NSURL URLWithString: aNews.image];
    [cell.imageView setImageWithURL: image];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Select row at index
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
