//
//  ViewController.m
//  SimpleWeatherApp
//
//  Created by Наталья on 30.01.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

#import "ViewController.h"
#import "WeatherRequestService.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offsetConstraint;
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (nonatomic, strong) NSString *resultWeather;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
  
 

    WeatherRequestService *weatherService = [WeatherRequestService new];
    [weatherService getImageWithSuccessBlock:^(NSData *result)
     {
         UIImage *downloadImage = [UIImage imageWithData:result];
         self.image.image = downloadImage;
     } andErrorBlock:^(NSError *error) {
         NSLog(@"%@, Картинки нет",error);
     }];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

   
}

- (void)keyboardWillShown:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbsize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:.3 animations:^{
        CGFloat kbHeight = kbsize.height;
        self.offsetConstraint.constant = - kbHeight / 2;
        [self.view layoutIfNeeded];
    }];
    
    
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:.3 animations:^{

        self.offsetConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)tabGestureHandler:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)searchButtonHandler:(id)sender {
    WeatherRequestService *service = [WeatherRequestService new];
    [service getWeatherByCityName:self.cityText.text withSuccesBlock:^(NSString *result) {
     
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultWeather = result;
            [self performSegueWithIdentifier:@"detailSegue" sender:nil];
        });
        
    } andErrorBlock:^(NSError *error) {
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"detailSegue"]){
        DetailViewController *dest = segue.destinationViewController;
        dest.weather = self.resultWeather;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
