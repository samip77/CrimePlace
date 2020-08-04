/**Category used for UIViewController to method to display Alert which is later used to display API error if any.*/
//  UIViewController+Alert.h
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VoidCompletionBlock)(void);

@interface UIViewController (Alert)

- (void)displayAlert:(NSString *)message
   withActionMessage:(NSString *)actionMessage
  onActionCompletion:(VoidCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
