//
//  WeatherRequestService.m
//  SimpleWeatherApp
//
//  Created by Наталья on 30.01.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

#import "WeatherRequestService.h"

static NSString const *url = @"http://api.openweathermap.org/data/2.5/weather?appid=6dd4e82d58639fe3edf0e4cbecdafdc5";
static NSString const *imageUrl = @"http://www.dnepr-333.dp.ua/favicon.png";

@interface WeatherRequestService ()

@end

@implementation WeatherRequestService



- (void)getWeatherByCityName:(NSString *)cityName withSuccesBlock:(void(^)(NSString *result))successBlock andErrorBlock:(void(^)(NSError *error))errorBlock
{
    NSString *fullUrlSttring = [NSString stringWithFormat:@"%@&q=%@",url, cityName];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:fullUrlSttring] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            errorBlock(error);
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSString *result = [NSString stringWithFormat:@"%@", dict[@"main"][@"temp"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            successBlock(result);
        });
    
        
        
        
        
        
        
    }];
    [dataTask resume];
    
}

- (void)getImageWithSuccessBlock:(void(^)(NSData *result))successBlock andErrorBlock:(void(^)(NSError *error))errorBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadImageTask = [session downloadTaskWithURL:[NSURL URLWithString:imageUrl] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            errorBlock(error);
            return ;
        }
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
             successBlock(imageData);
        });
       
        
    }];
    
    [downloadImageTask resume];
}

@end
