//
//  WeatherRequestService.h
//  SimpleWeatherApp
//
//  Created by Наталья on 30.01.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherRequestService : NSObject

- (void)getWeatherByCityName:(NSString *)cityName withSuccesBlock:(void(^)(NSString *result))successBlock andErrorBlock:(void(^)(NSError *error))errorBlock;

- (void)getImageWithSuccessBlock:(void(^)(NSData *result))successBlock andErrorBlock:(void(^)(NSError *error))errorBlock;

@end
