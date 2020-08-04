//
//  AlertView.h
//  Crime Place
//
//  Created by Samip shah on 8/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitlelabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)okButtonAction:(id)sender;
+ (AlertView *)loadFromNib;
- (void)showAlertwithTitle:(NSString*)title
              withSubtitle:(NSString *)subtitle
             andButtonName:(NSString *)buttonTitle
                    onView:(UIView *)superview;

@end

NS_ASSUME_NONNULL_END
