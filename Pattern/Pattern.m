//
//  Pattern.m
//  SockItToMe
//
//  Created by Diane Hoffstetter on 8/5/19.
//  Copyright © 2019 Dumb Blonde Software. All rights reserved.
//

#import "Pattern.h"

@implementation Pattern

@synthesize stitchGauge = _stitchGauge;


// Input parameters

float rowGauge;
float pctNegativeEase;
float sockHeight;

// Calculated parameters
int numFootStitches;
int numCastOnStitchesPerNeedle;
int numCastOnStitchesTotal;

int numToeIncreaseRows;
int numToeStraightRows;
float lengthToeIncreaseSection;

int numShortRowHealRemainingStitches;
int numShortRowHealRows;
float pctShortRowHealBottomFoot;
float lengthShortRowHealBottomFoot;

float lengthMidFoot; // From end of toe increase to start of SR heal
int numMinFootRows;


-(void) setStitchGauge: (float)sg {
  
  sg = round(sg);
  self.stitchGauge = sg;
}
-(float) stitchGauge {
  
  return self.stitchGauge;
}

@end

