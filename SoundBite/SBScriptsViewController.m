//
//  SBScriptsViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import "SBScriptsViewController.h"

@interface SBScriptsViewController ()

@end

@implementation SBScriptsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SBScripts sharedSBScripts] loadForUser:self.user withDelegate:self];
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSLog(@"Data is ready.");
	if (sbSoapReady.error) {
		NSString *msg = nil;
		if (self.user.userName.length > 0)
			msg = [[NSString alloc] initWithFormat:@"Can't authenticate %@ on stack %@.", self.user.userName, self.user.stack];
		else
			msg = @"Can't authenticate using the credentials provided.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
	} else {
		NSLog(@"Reloading data in table.");
		[self.tableView reloadData];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SBScripts sharedSBScripts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScriptsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	NSUInteger row = [indexPath row];
	
    //Script version is not being returned
	cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [[SBScripts sharedSBScripts] nameForRow:row], [[SBScripts sharedSBScripts] versionForRow:row]];
    cell.detailTextLabel.text = [[SBScripts sharedSBScripts] descriptionForRow:row];
    
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *sectionHeader = [[NSString alloc] initWithFormat:@"%@ (%@)", self.user.account, self.user.stack];
	return sectionHeader;
}

@end
