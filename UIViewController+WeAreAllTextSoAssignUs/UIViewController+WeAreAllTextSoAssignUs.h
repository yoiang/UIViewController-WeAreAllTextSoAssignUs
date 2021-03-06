//
//  UIViewController+WeAreAllTextSoAssignUs.h
//  We Are All Text So Assign Us
//
//  Created by Ian on 11/5/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WeAreAllTextSoAssignUs)

- (void)mapViews:(NSArray *)views forKey:(NSString *)key;
- (void)mapLabel:(UILabel *)label
       andButton:(UIButton *)button
    andTextField:(UITextField *)textField
     andTextView:(UITextView *)textView
          forKey:(NSString *)key;

- (void)setText:(NSString *)text toViews:(NSArray *)views;
- (void)setText:(NSString *)text toViewsWithKey:(NSString *)key;
- (void)setText:(NSString *)text
        toLabel:(UILabel *)label
      andButton:(UIButton *)button
   andTextField:(UITextField *)textField
    andTextView:(UITextView *)textView;

- (void)setHidden:(BOOL)hidden toViews:(NSArray *)views;
- (void)setHidden:(BOOL)hidden toViewsWithKey:(NSString *)key;
- (void)setHidden:(BOOL)hidden
          toLabel:(UILabel *)label
        andButton:(UIButton *)button
     andTextField:(UITextField *)textField
      andTextView:(UITextView *)textView;

@end
