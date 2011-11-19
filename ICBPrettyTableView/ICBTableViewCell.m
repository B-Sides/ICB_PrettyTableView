//
//  ICBTableViewCell.m
//  ICBPrettyTableView
//
//  Created by James Van Metre on 11/17/11.
//  Copyright (c) 2011 ELC Technologies. All rights reserved.
//

#import "ICBTableViewCell.h"

@implementation ICBTableViewCell

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize email = _email;
@synthesize phone = _phone;
@synthesize address = _address;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getFirstEmail:(ABRecordRef)record
{
    ABMultiValueRef valueRef = ABRecordCopyValue(record, kABPersonEmailProperty);
    NSInteger count = ABMultiValueGetCount(valueRef);
    if (count > 0) {
        NSString *string = (NSString *)ABMultiValueCopyValueAtIndex(valueRef, 0);
        CFRelease(valueRef);
        return [string autorelease];
    } else {
        CFRelease(valueRef);
        return nil;
    }
}

- (NSString *)getFirstPhone:(ABRecordRef)record
{
    ABMultiValueRef valueRef = ABRecordCopyValue(record, kABPersonPhoneProperty);
    NSInteger count = ABMultiValueGetCount(valueRef);
    if (count > 0) {
        NSString *string = (NSString *)ABMultiValueCopyValueAtIndex(valueRef, 0);
        CFRelease(valueRef);
        return [string autorelease];
    } else {
        CFRelease(valueRef);
        return nil;
    }    
}

- (void)setRecord:(ABRecordRef)record
{
    self.firstName = [(NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty) autorelease];
    self.lastName = [(NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty) autorelease];
    self.email = [self getFirstEmail:record];
    self.phone = [self getFirstPhone:record];
    [self setNeedsDisplay];
}

- (void)setDictionary:(NSDictionary *)dict
{
    self.firstName = [dict objectForKey:@"firstName"];
    self.lastName = [dict objectForKey:@"lastName"];
    self.email = [dict objectForKey:@"email"];
    self.phone = [dict objectForKey:@"phone"];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextClipToRect(ctx, rect);
    //If even
    if (((self.tag % 2) == 0)) {
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.1f alpha:1.f].CGColor);
    } else {
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.15f alpha:1.f].CGColor);
    }

    CGContextFillRect(ctx, rect);

    //Vertically center our text, if no email
    BOOL isCentered = (self.email == nil);
    
    CGRect tempRect;
    CGFloat midY = CGRectGetMidY(rect);
    [[UIColor whiteColor] set];
    UIFont *defaultFont = [UIFont systemFontOfSize:16];
    CGSize size = [self.firstName sizeWithFont:defaultFont];
    if (isCentered == NO) {
        tempRect = CGRectMake(5, 0, size.width, size.height);
    } else {
        tempRect = CGRectMake(5, midY - size.height/2, size.width, size.height);
    }
    [self.firstName drawInRect:tempRect withFont:defaultFont];
    
    [[UIColor lightGrayColor] set];
    size = [self.lastName sizeWithFont:defaultFont];
    if (isCentered == NO) {
        tempRect = CGRectMake(CGRectGetMaxX(tempRect)+5, 0, size.width, size.height);
    } else {
        tempRect = CGRectMake(CGRectGetMaxX(tempRect)+5, midY - size.height/2, size.width, size.height);
    }
    [self.lastName drawInRect:tempRect withFont:defaultFont];
    
    if (self.phone != nil) {
        [[UIColor redColor] set];
        size = [self.phone sizeWithFont:defaultFont];
        CGFloat end = CGRectGetMaxX(tempRect) + size.width;
        if (end > rect.size.width) {
            size.width = CGRectGetMaxX(rect) - CGRectGetMaxX(tempRect) - 10; //-10 so that we get 5 from the end of last name, and 5 from the end of rect
        }
        if (isCentered == NO) {
            tempRect = CGRectMake(CGRectGetMaxX(rect) - size.width - 5, 0, size.width, size.height);
        } else {
            tempRect = CGRectMake(CGRectGetMaxX(rect) - size.width - 5, midY - size.height/2, size.width, size.height);
        }
        [self.phone drawInRect:tempRect withFont:defaultFont lineBreakMode:UILineBreakModeTailTruncation];
    }
    
    if (self.email != nil) {
        [[UIColor blueColor] set];
        size = [self.email sizeWithFont:defaultFont];
        tempRect = CGRectMake(5, midY, size.width, size.height);
        [self.email drawInRect:tempRect withFont:defaultFont];
    }
}

@end
