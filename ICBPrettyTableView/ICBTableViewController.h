//
//  ICBViewController.h
//  ICBPrettyTableView
//
//  Created by James Van Metre on 11/17/11.
//  Copyright (c) 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface ICBTableViewController : UITableViewController
{
    ABAddressBookRef _addressBook;
}

@property (nonatomic, retain) NSArray *contacts;

@end
