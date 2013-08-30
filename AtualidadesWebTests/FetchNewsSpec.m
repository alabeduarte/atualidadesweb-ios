#import "Kiwi.h"
#import "ViewController.h"

SPEC_BEGIN(FetchNewsSpec)

describe(@"when view did load", ^{
    ViewController *viewController = [[ViewController alloc] init];
    [viewController viewDidLoad];
    
    it(@"should load all news", ^{
        int newsCount = [viewController.news count];
        [[theValue(newsCount) should] equal:theValue(130)];
    });
});

SPEC_END