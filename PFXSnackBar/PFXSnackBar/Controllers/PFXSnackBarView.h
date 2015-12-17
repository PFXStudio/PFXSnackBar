//
//  PFXSnackBarView.m
//  PFXSnackBar
//
//  Created by succorer on 2015. 12. 16..
//  Copyright © 2015년 succorer. All rights reserved.
//
//  AppStore : https://itunes.apple.com/kr/developer/ppark/id448017898
//  Homepage : http://pfxstudio.modoo.at
//  Facebook : http://www.facebook.com/PFXStudio
//  Twitter : https://twitter.com/PFXStudio
//  E-mail : pfxstudio21@gamil.com

#import <UIKit/UIKit.h>

@interface PFXSnackBarView : UIView

+ (instancetype)showSnackBarWithView:(UIView *)view message:(NSString *)message completion:(void (^)(void))completion;

@end
