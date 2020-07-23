//
//  UIViewController+Alert.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

-(void) displayAlert:(NSString *)message withActionMessage:(NSString *)actionMessage onActionCompletion:(VoidCompletionBlock)completion{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];

          UIAlertAction *action = [UIAlertAction actionWithTitle:actionMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              completion();
              
          }];
          UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
          [alert addAction:action];
          [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    });
    
    
}

@end
