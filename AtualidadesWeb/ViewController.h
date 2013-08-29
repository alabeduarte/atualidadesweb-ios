//
//  ViewController.h
//  AtualidadesWeb
//
//  Created by Alabê Duarte on 8/28/13.
//  Copyright (c) 2013 atualidadesweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate>

@property (strong, nonatomic) NSArray *news;
@property (strong, nonatomic) IBOutlet UINavigationItem *headerItem;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
