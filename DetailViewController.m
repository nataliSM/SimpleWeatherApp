//
//  DetailViewController.m
//  SimpleWeatherApp
//
//  Created by Наталья on 30.01.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()


@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weatherLabel.text = self.weather;
}

@end
