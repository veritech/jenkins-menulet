//
//  HEStatusBarView.h
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum _HEStatusBarViewState {
  HEStatusBarViewStateSuccess,
  HEStatusBarViewStateFailure, 
  HEStatusBarViewStateLoading
} HEStatusBarViewState;

@interface HEStatusBarView : NSView

@property (nonatomic,assign) HEStatusBarViewState state;
@property (weak) NSStatusItem *statusBarItem;

- (void)showSuccess;
- (void)showFailure;

@end
