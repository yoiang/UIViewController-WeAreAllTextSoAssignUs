//
//  UIViewController+WeAreAllTextSoAssignUs.m
//  We Are All Text So Assign Us
//
//  Created by Ian on 11/5/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "UIViewController+WeAreAllTextSoAssignUs.h"

@interface UIViewController (WeAreAllTextSoAssignUsPrivate)

@property (strong, readwrite) NSMutableDictionary *viewGroups;

@end

@implementation UIViewController (WeAreAllTextSoAssignUs)

- (void)mapViews:(NSArray *)views forKey:(NSString *)key
{
    [self.viewGroups setObject:views forKey:key];
}

- (void)callOnViews:(void (^)(NSArray *views) )callBlock forKey:(NSString *)key
{
    id viewsId = [self.viewGroups objectForKey:key];
    if (viewsId && [viewsId isKindOfClass:[NSArray class] ] )
    {
        NSArray *views = (NSArray *)viewsId;
        callBlock( views );
    }
}

+ (void)setText:(NSString *)text toView:(UIView *)view
{
    if ( [view isKindOfClass:[UILabel class] ] )
    {
        UILabel *label = (UILabel *)view;
        label.text = text;
    } else if ( [view isKindOfClass:[UIButton class] ] )
    {
        UIButton *button = (UIButton *)view;
        button.titleLabel.text = text;
    } else if ( [view isKindOfClass:[UITextField class] ] )
    {
        UITextField *textField = (UITextField *)view;
        textField.text = text;
    } else if ( [view isKindOfClass:[UITextView class] ] )
    {
        UITextView *textView = (UITextView *)view;
        textView.text = text;
    }
}

- (void)setText:(NSString *)text toViews:(NSArray *)views
{
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [UIViewController setText:text toView:obj];
    } ];
}

- (void)setText:(NSString *)text toViewsWithKey:(NSString *)key
{
    [self callOnViews:^(NSArray *views) {
        [self setText:text toViews:views];
    } forKey:key];
}

- (void)setText:(NSString *)text
        toLabel:(UILabel *)label
      andButton:(UIButton *)button
   andTextField:(UITextField *)textField
    andTextView:(UITextView *)textView
{
    [self setText:text toViews:@[label, button, textField, textView] ];
}
}

@end
