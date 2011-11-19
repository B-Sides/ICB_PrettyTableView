//
//  ICBTableViewCell.h
//  ICBPrettyTableView
//
//  Created by James Van Metre on 11/17/11.
//  Copyright (c) 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface ICBTableViewCell : UITableViewCell

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *phone;
//@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *address;

- (void)setRecord:(ABRecordRef)record;
- (void)setDictionary:(NSDictionary *)dict;

@end
