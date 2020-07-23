/**Singleton Class used for API service for CrimePlaces.*/
//  APIService.h
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

NS_ASSUME_NONNULL_BEGIN
/** Bloc used as functional paramter to call  and used when API request  is completed to provide result Array of Place and Error Message if any.*/
typedef void (^CompletionBlock)(NSArray* _Nullable places, NSString* _Nullable error);

@interface APIService : NSObject

+(instancetype) sharedInstance;
-(void) getCrimePlacesfromLatitute:(double) latitude andLongitude:(double) longitude atDate:(NSString *)date withCompletion: (CompletionBlock) completion;

@end

NS_ASSUME_NONNULL_END
