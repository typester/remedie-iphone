#import "BonjourBrowser.h";

@implementation BonjourBrowser

@synthesize serviceBrowser, table, remedies, resolve_queue;

-(void)loadView {
    serviceBrowser = [[NSNetServiceBrowser alloc] init];
    serviceBrowser.delegate = self;
    [serviceBrowser searchForServicesOfType:@"_remedie._tcp" inDomain:@"local"];

    table = [[UITableView alloc]
                initWithFrame:[[UIScreen mainScreen] applicationFrame]
                style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;

    remedies = [[NSMutableArray alloc] initWithCapacity:20];
    resolve_queue = [[NSMutableArray alloc] initWithCapacity:20];

    self.view = table;
}

-(void)dealloc {
    [serviceBrowser release];
    [remedies release];
    [resolve_queue release];
    [super dealloc];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)nsb
          didFindService:(NSNetService *)ns moreComing:(BOOL)more {

    [resolve_queue addObject:ns];

    NSLog(@"Found: %@", ns.name);
    ns.delegate = self;
    [ns resolveWithTimeout:10];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)nsb
        didRemoveService:(NSNetService *)ns moreComing:(BOOL)more {
    NSLog(@"Remove: %@", ns.name);

    NSUInteger i = [remedies indexOfObject:ns];

    if (i >= 0) {
        [remedies removeObject:ns];

        NSArray *indexPaths =
            [NSArray arrayWithObjects:
                         [NSIndexPath indexPathForRow:i inSection:0],
                     nil];

        [table beginUpdates];
        [table deleteRowsAtIndexPaths:indexPaths withRowAnimation:NO];
        [table endUpdates];
    }
}

-(void)netServiceDidResolveAddress:(NSNetService *)ns {
    NSLog(@"Resolved %@ (%@:%d)", ns.name, ns.hostName, ns.port);

    NSArray *indexPaths =
        [NSArray arrayWithObjects:
                     [NSIndexPath indexPathForRow:remedies.count inSection:0],
                 nil];

    [remedies addObject:ns];
    [resolve_queue removeObject:ns];

    [table beginUpdates];
    [table insertRowsAtIndexPaths:indexPaths
           withRowAnimation:UITableViewRowAnimationTop];
    [table endUpdates];
}

-(void)netService:(NSNetService *)ns didNotResolve:(NSDictionary *)err {
    NSLog(@"Cannot resolve %@'s address", ns.name);
    [resolve_queue removeObject:ns];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)t {
    return 1;
}

-(NSInteger)tableView:(UITableView *)t numberOfRowsInSection:(NSInteger)section {
    return [remedies count];
}

-(UITableViewCell *)tableView:(UITableView *)t cellForRowAtIndexPath:(NSIndexPath *)i {
    UITableViewCell *cell = [t dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
                                        reuseIdentifier:@"myCell"] autorelease];
    }

    NSNetService *ns = [remedies objectAtIndex:0];
    cell.text = ns.name;

    return cell;
}

-(void)tableView:(UITableView *)t didSelectRowAtIndexPath:(NSIndexPath *)ip {
    NSNetService *ns = [remedies objectAtIndex:ip.row];

    NSLog(@"Open %@ (%@:%d)", ns.name, ns.hostName, ns.port);
    NSURL *url = [NSURL URLWithString:
                            [NSString stringWithFormat:@"http://%@:%d/",
                                      ns.hostName, ns.port]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
