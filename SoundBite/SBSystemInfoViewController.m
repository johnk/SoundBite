//
//  SBSystemInfoViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import "SBSystemInfoViewController.h"

@interface SBSystemInfoViewController ()

@end

@implementation SBSystemInfoViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
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
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

    self.sbSoap = [[SBSoap2 alloc] init];
    self.sbSoap.currentUser = self.user;
    
    NSURL *url = [SBSoap2 sbSoapCreateURL:(self.user.stack) service:kPlatformManagementService];
    NSString *request = [SBSoap2 sbSoapCreateRequest:self.user soapBody:kshowSystemInfo];
    
    [self.sbSoap sbSoapSendRequest:url request:request delegate:self];

    NSLog(@"showSystemInfo: initiated request");
	
    //self.sbSoap = [[SBSoap2 alloc] init];
	//[self.sbSoap request:self.user requestTemplate:kshowSystemInfoRequestTemplateV2 urlTemplate:kshowSystemInfoUrlTemplateV2 delegate:self];
	//NSLog(@"Initiated SBSoap request.");
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

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *xpath = @"/Envelope/Body/showSystemInfoResponse/return/data";
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    
    NSLog(@"ShowSystmInfoViewController: %d sysinfo attributes", [nodes count]);
    
    //for (GDataXMLElement *node in nodes) {
    //    NSLog(@"%@", node.stringValue);
    //}
    
    return [nodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SystemInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
	NSUInteger row = [indexPath row];

	NSString *xpath = [NSString stringWithFormat:@"/Envelope/Body/showSystemInfoResponse/return/data[%d]/name", row+1];
	NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    cell.textLabel.text = [nodes[0] stringValue];
	//cell.nameLabel.text = [nodes[0] stringValue];
	
	xpath = [NSString stringWithFormat:@"/Envelope/Body/showSystemInfoResponse/return/data[%d]/value", row+1];
    nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    cell.detailTextLabel.text = [nodes[0] stringValue];
	
    return cell;
}

@end
