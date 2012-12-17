//
//  HEStatusBarView.m
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import "HEStatusBarView.h"
#import <QuartzCore/QuartzCore.h>

@interface HEStatusBarView ()

@property (strong) CALayer *imageLayer;

@end

@implementation HEStatusBarView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
      
      [self setLayer:[CALayer layer]];
      [self setWantsLayer:YES];
      
      NSLog(@"Layer %@",self);

      [self setState:HEStatusBarViewStateLoading];
      
      [self setImageLayer:[CALayer layer]];
      
      [[self imageLayer] setContents:[NSImage imageNamed:@"working_empty"]];
      [[self imageLayer] setFrame:NSMakeRect(2.5, 4, 15, 15)];
      
      [[self layer] addSublayer:[self imageLayer]];
    }
    
    return self;
}


- (void)pulsate {
  
  CAKeyframeAnimation *pulsing;
  
  NSArray *images = @[
               [NSImage imageNamed:@"working_empty"],
               [NSImage imageNamed:@"working_full"]
  ];
  
  pulsing = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
  
  [pulsing setValues:images];
  
  [pulsing setDuration:0.5f];
  
  [pulsing setRepeatCount:HUGE_VALF];
  
  [pulsing setAutoreverses:YES];
  
  [[self imageLayer] addAnimation:pulsing
                      forKey:@"pulsing"];
  
}

- (void)animateToImage:(NSImage *)aImage {
  
  CABasicAnimation *animation;
  
  animation = [CABasicAnimation animationWithKeyPath:@"contents"];
  
  [animation setToValue:aImage];
  
  [animation setFillMode:kCAFillModeForwards];
  
  [animation setDuration:0.5f];
  
  [animation setRemovedOnCompletion:NO];
  
  [[self imageLayer] addAnimation:animation
                      forKey:@"success"];
  
}

- (void)setState:(HEStatusBarViewState)state {
  
  _state = state;
  
  switch(state) {
    case HEStatusBarViewStateSuccess:
      [self showSuccess];
      break;
    case HEStatusBarViewStateFailure:
      [self showFailure];
      break;
    case HEStatusBarViewStateLoading:
      [self pulsate];
      break;
    default:
      break;
  }
}

- (void)showSuccess {
  [self animateToImage:[NSImage imageNamed:@"success"]];
}

- (void)showFailure {
  [self animateToImage:[NSImage imageNamed:@"error"]];
}

#pragma Events
- (void)mouseDown:(NSEvent *)theEvent {
  [[self statusBarItem] popUpStatusItemMenu:[[self statusBarItem] menu]];
}

@end
