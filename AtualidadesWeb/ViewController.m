//
//  ViewController.m
//  AtualidadesWeb
//
//  Created by Alabê Duarte on 8/28/13.
//  Copyright (c) 2013 atualidadesweb. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "NewsUpdater.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setHidden: YES];
    
    NewsUpdater *updater = [[NewsUpdater alloc] init];
    [updater updateNews: ^(NSArray *result) {
        self.news = result;
        
        [self.tableView setHidden: NO];
        [self.tableView reloadData];
        
        self.headerItem.title = @"Atualidades | Web";
    }];
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
