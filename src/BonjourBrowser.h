#import <UIKit/UIKit.h>

@interface BonjourBrowser : UIViewController
    <UITableViewDelegate, UITableViewDataSource> {

    NSNetServiceBrowser *serviceBrowser;
    UITableView *table;
    NSMutableArray *remedies;
    NSMutableArray *resolve_queue;
}

@property (nonatomic, retain) NSNetServiceBrowser *serviceBrowser;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *remedies;
@property (nonatomic, retain) NSMutableArray *resolve_queue;

@end
