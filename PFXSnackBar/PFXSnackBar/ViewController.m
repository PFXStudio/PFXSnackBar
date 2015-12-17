//
//  ViewController.m
//  PFXSnackBar
//
//  Created by succorer on 2015. 12. 16..
//  Copyright © 2015년 succorer. All rights reserved.
//

#import "ViewController.h"
#import "PFXSnackBarView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *centerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)barButtonTouched:(id)sender {
    [PFXSnackBarView showSnackBarWithView:self.view message:@"bottomMessage" completion:^{
        [PFXSnackBarView showSnackBarWithView:self.topView message:@"topViewMessage" completion:^{
            [PFXSnackBarView showSnackBarWithView:self.centerView message:@"centerViewMessage" completion:nil];
        }];
    }];
}

@end
