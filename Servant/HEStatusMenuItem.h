//
//  HEStatusMenuItem.h
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HEStatusMenuItem : NSMenuItem

@property (nonatomic,weak) IBOutlet NSTextField *buildLabel;
@property (nonatomic,weak) IBOutlet NSTextField *dateLabel;

- (void) formatObject:(id) obj;

@end
