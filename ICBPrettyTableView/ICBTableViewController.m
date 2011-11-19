//
//  ICBViewController.m
//  ICBPrettyTableView
//
//  Created by James Van Metre on 11/17/11.
//  Copyright (c) 2011 ELC Technologies. All rights reserved.
//

#import "ICBTableViewController.h"
#import "ICBTableViewCell.h"

@implementation ICBTableViewController

@synthesize contacts = _contacts;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    CFRelease(_addressBook);
    [_contacts release];
    _contacts = nil;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColor.blackColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _addressBook = ABAddressBookCreate();
    NSArray *tempArray = [(NSArray *)ABAddressBookCopyArrayOfAllPeople(_addressBook) autorelease];
    tempArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = (NSString *)ABRecordCopyCompositeName((ABRecordRef)obj1);
        NSString *name2 = (NSString *)ABRecordCopyCompositeName((ABRecordRef)obj2);
        [name1 autorelease];
        [name2 autorelease];
        return [name1 compare:name2];
    }];
    
    if ([tempArray count] > 0) {
        self.contacts = tempArray;
    } else {
        NSMutableArray *tempMutableArray = [NSMutableArray arrayWithCapacity:100];
        for (int i = 0; i < 100; ++i) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if ((i % 9) != 0) {
                [dict setObject:[NSString stringWithFormat:@"FirstName%d", i] forKey:@"firstName"];
            }
            if ((i % 3) == 0) {
                [dict setObject:[NSString stringWithFormat:@"LastName%d", i] forKey:@"lastName"];
            }
            if ((i % 3) == 0 && (i % 2) == 0) {
                [dict setObject:[NSString stringWithFormat:@"emailTest%d@test%d.com", i, i] forKey:@"email"];
            }
            if ((i % 7) == 0) {
                NSString *string = [NSString stringWithFormat:@"%d", i];
                while ([string length] < 10) {
                    string = [string stringByAppendingFormat:@"%@", string];
                }
                [dict setObject:string forKey:@"phone"];
            }
            [tempMutableArray addObject:dict];
        }
        self.contacts = tempMutableArray;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contacts count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    static NSString *CellIdentifier = @"ICBTableViewCellIdentifier";
    
    ICBTableViewCell *cell = (ICBTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ICBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.delegate = self;
        cell.textLabel.textColor = UIColor.whiteColor;
    }
    cell.tag = indexPath.row;
    
    NSObject *object = [self.contacts objectAtIndex:indexPath.row];
    if ([object isKindOfClass:NSDictionary.class]) {
        [cell setDictionary:(NSDictionary *)object];
    } else {
        [cell setRecord:(ABRecordRef)object];
    }
    
    return cell;
}

@end
