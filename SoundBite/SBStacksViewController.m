//
//  SBStacksViewController.m
//  SoundBite
//
//  Created by John Keyes on 3/29/14.
//  Copyright (c) 2014 John Keyes. All rights reserved.
//

#import "SBStacksViewController.h"

@interface SBStacksViewController ()

@end

@implementation SBStacksViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    NSLog(@"row = %d", [indexPath row]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.stack) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.stackIndex inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //self.currentStack = [indexPath row];
    //NSDictionary *stackDict = [[[SBStacks sharedSBStacks] sbStacks] objectAtIndex:[indexPath row]];
	//self.currentStackValue = stackDict[@"value"];
    
    self.stack = [[[SBStacks sharedSBStacks] sbStacks] objectAtIndex:[indexPath row]];
    self.stackIndex = [indexPath row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self.delegate stacksViewController:self didSelectStack:self.stack];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SBStacks sharedSBStacks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StacksCell" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    NSString *stackForRow = [[[SBStacks sharedSBStacks] sbStacks] objectAtIndex:row];
    
    //if (row == self.currentStack) {
    //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //} else {
    //    cell.accessoryType = UITableViewCellAccessoryNone;
    //}
    
    if ([self.stack isEqualToString:stackForRow]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.stackIndex = row;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

	//NSDictionary *stackDict = [[[SBStacks sharedSBStacks] sbStacks] objectAtIndex:row];
	cell.textLabel.text = stackForRow;
    return cell;
}

@end
