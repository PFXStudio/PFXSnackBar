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

#import "PFXSnackBarView.h"

#define BAR_HEIGHT 30
#define BAR_ANIMATION_DELAY 0.3
#define BAR_SHOW_SECOND 1
#define BAR_SHOW_ALPHA 0.8

@interface PFXSnackBarView ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation PFXSnackBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)showSnackBarWithView:(UIView *)view message:(NSString *)message completion:(void (^)(void))completion
{
    NSString *className = NSStringFromClass([PFXSnackBarView class]);
    NSString *pathToNIB = [[NSBundle bundleForClass:[PFXSnackBarView class]] pathForResource: className ofType:@"nib"];
    if ([pathToNIB length] <= 0)
    {
        NSLog(@"Wrong PFXSnackBarView");
        return nil;
    }
    
    UINib *nib = [UINib nibWithNibName:className bundle:[NSBundle mainBundle]];
    PFXSnackBarView *snackBarView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    [snackBarView setAlpha:0];
    [snackBarView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [snackBarView setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y + view.frame.size.height, view.frame.size.width, BAR_HEIGHT)];
    [snackBarView.messageLabel setText:message];
    [view addSubview:snackBarView];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:snackBarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:BAR_HEIGHT];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:snackBarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.f constant:BAR_HEIGHT];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:snackBarView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:snackBarView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
    
    [snackBarView addConstraints:[NSArray arrayWithObjects:heightConstraint, nil]];
    [view addConstraints:[NSArray arrayWithObjects:bottomConstraint, leadingConstraint, trailingConstraint, nil]];
    
    NSLayoutConstraint *didAppearConstraint = [NSLayoutConstraint constraintWithItem:snackBarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    [UIView animateWithDuration:BAR_ANIMATION_DELAY animations:^{
        [snackBarView setAlpha:BAR_SHOW_ALPHA];
        [view removeConstraint:bottomConstraint];
        [view addConstraint:didAppearConstraint];
        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(BAR_SHOW_SECOND * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:BAR_ANIMATION_DELAY animations:^{
                [snackBarView setAlpha:0];
                [view removeConstraint:didAppearConstraint];
                [view addConstraint:bottomConstraint];
                [view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [snackBarView removeFromSuperview];
                if (completion == nil)
                {
                    return;
                }
                
                completion();
            }];
        });
    }];

    return snackBarView;
}

@end
