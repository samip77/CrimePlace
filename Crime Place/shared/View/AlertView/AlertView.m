//
//  AlertView.m
//  Crime Place
//
//  Created by Samip shah on 8/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "AlertView.h"
#import "SceneDelegate.h"

@implementation AlertView

-(IBAction) okButtonAction:(id)sender {
    [self removeSelfFromSuperView];
}

/**Use this method to provide input to Alert view and display it*/
-(void) showAlertwithTitle:(NSString*) title withSubtitle:(NSString *) subtitle andButtonName:(NSString *) buttonTitle onView:(UIView *)superview{
    self.frame = UIScreen.mainScreen.bounds;
    self.titleLabel.text = title;
    self.subtitlelabel.text = subtitle;
    [self.okButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    self.contentView.layer.cornerRadius = 4.0;
    self.contentView.layer.masksToBounds = YES;
    [self addViewToSuperview:superview];
}

/** Use this method to  init and get the Alertview instance*/
+(AlertView *) loadFromNib{
    AlertView *view = (AlertView *) [[UINib nibWithNibName:@"AlertView" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil].firstObject;
    return view;
}

/** Adding scale and alpha animation while keeping the alert view on superview*/
-(void) addViewToSuperview:(UIView *) superview{
    self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.alpha = 0;
    
    [superview addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

/** Adding scale and alpha animation while removing the alert view from superview*/
-(void) removeSelfFromSuperView{
    self.alpha = 1;
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.alpha = 0;;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
