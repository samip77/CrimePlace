//
//  APIService.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//
#import "APIService.h"
#import <Foundation/Foundation.h>
#import "Define.h"
#import "CrimePlace.h"


@implementation APIService{
    NSURLSessionDataTask *dataTask;
}

/** Creates a Singleton instance of the API service.This is used by external classes to initialize the APIService*/
+(instancetype) sharedInstance
{
    static APIService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIService alloc] init];
    });
    return sharedInstance;
}

/**Used for API request of Crime Places near the given coordinate and return result using Completion Block*/
-(void) getCrimePlacesfromLatitute:(double) latitude andLongitude:(double) longitude atDate:(NSString *)date withCompletion: (CompletionBlock) completion{
    
    // Setup the request with URL
    NSURL *url = [NSURL URLWithString:BASE_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Convert POST string parameters to data using UTF8 Encoding
    NSString *postParams = [NSString stringWithFormat:@"lat=%f&lng=%f&date=%@",latitude,longitude,date];
    NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    // Create dataTask with sharedSession
    dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                ^(NSData * _Nullable data,
                  NSURLResponse * _Nullable response,
                  NSError * _Nullable error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *errorMessage = [NSString stringWithFormat:@"Error Code: %ld\n%@",(long)error.code,error.localizedDescription];
                completion(nil,errorMessage);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *crimePlaces = [self crimePlaceArrayFromData:data];
                completion(crimePlaces,nil);
            });
        }
        
    }] ;
    
    // Fire the request
    [dataTask resume];
}

/**
 Parses the NSData from the NSURLSession DataTask and return the parsed the Array of CrimePlace
 @parameter data    NSData received from NSURLSession DataTask
 @return NSArray   CrimePlace array parsed from the data
 */
-(NSArray *) crimePlaceArrayFromData:(NSData * _Nullable) data {
    
    NSError *parsingError;
    NSMutableArray *places = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parsingError];
    
    NSMutableArray *crimePlaces = [NSMutableArray new];
    
    for (NSDictionary *placeDict in places){
        CrimePlace *place = [CrimePlace new];
        place.placeId = [placeDict valueForKey:@"id"];
        place.category = [placeDict valueForKey:@"category"];
        place.context = [placeDict valueForKey:@"context"];
        place.locationSubtype = [placeDict valueForKey:@"location_subtype"];
        place.locationtype = [placeDict valueForKey:@"location-type"];
        place.month = [placeDict valueForKey:@"month"];
        place.outcomeStatus = [placeDict valueForKey:@"outcome_status"];
        place.persistentId = [placeDict valueForKey:@"persistent_id"];
        
        NSDictionary *locationDict = [placeDict valueForKey:@"location"];
        Location *location = [Location new];
        location.latitude =  [[locationDict valueForKey:@"latitude"] doubleValue];
        location.longitude = [[locationDict valueForKey:@"longitude"] doubleValue];
        
        NSDictionary *streetDict = [locationDict valueForKey:@"street"];
        Street *street = [Street new];
        street.streetId = [streetDict valueForKey:@"id"];
        street.name = [streetDict valueForKey:@"name"];
        
        location.street = street;
        place.location = location;
        [crimePlaces addObject:place];
    }
    
    return [crimePlaces copy];
}

@end

