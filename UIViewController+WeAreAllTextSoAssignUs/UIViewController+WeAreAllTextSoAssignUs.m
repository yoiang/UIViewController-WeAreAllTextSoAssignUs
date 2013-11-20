//
//  UIViewController+WeAreAllTextSoAssignUs.m
//  We Are All Text So Assign Us
//
//  Created by Ian on 11/5/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "UIViewController+WeAreAllTextSoAssignUs.h"

#import <objc/runtime.h>

NSString *const WeAreAllTextSoAssignUsViewGroupsKey = @"WeAreAllTextSoAssignUsViewGroups";

@interface UIViewController (WeAreAllTextSoAssignUsPrivate)

@property (strong, readwrite) NSMutableDictionary *viewGroups;

@end

@implementation NSMutableArray (WeAreAllTextSoAssignUs)

- (void)addObjectNilSafe:(id)object
{
    if (object)
    {
        [self addObject:object];
    }
}

@end

@implementation NSArray (WeAreAllTextSoAssignUs)

+ (NSArray *)arrayOfLabel:(UILabel *)label
                andButton:(UIButton *)button
             andTextField:(UITextField *)textField
              andTextView:(UITextView *)textView
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectNilSafe:label];
    [array addObjectNilSafe:button];
    [array addObjectNilSafe:textField];
    [array addObjectNilSafe:textView];
    return array;
}

@end

@implementation UIViewController (WeAreAllTextSoAssignUs)

- (void)mapViews:(NSArray *)views forKey:(NSString *)key
{
    [self.viewGroups setObject:views forKey:key];
}

- (void)mapLabel:(UILabel *)label
       andButton:(UIButton *)button
    andTextField:(UITextField *)textField
     andTextView:(UITextView *)textView
          forKey:(NSString *)key
{
    [self mapViews:[NSArray arrayOfLabel:label andButton:button andTextField:textField andTextView:textView]
            forKey:key];
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

- (void)setViewGroups:(NSMutableDictionary *)viewGroups
{
	objc_setAssociatedObject(self, CFBridgingRetain(WeAreAllTextSoAssignUsViewGroupsKey), viewGroups, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)viewGroups
{
	NSMutableDictionary *result = (NSMutableDictionary *)objc_getAssociatedObject(self, CFBridgingRetain(WeAreAllTextSoAssignUsViewGroupsKey) );
    if (!result)
    {
        result = [NSMutableDictionary dictionary];
        self.viewGroups = result;
    }
    return result;
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
    [self setText:text
          toViews:[NSArray arrayOfLabel:label andButton:button andTextField:textField andTextView:textView] ];
}

+ (void)setHidden:(BOOL)hidden toView:(UIView *)view
{
    [view setHidden:hidden];
}

- (void)setHidden:(BOOL)hidden toViews:(NSArray *)views
{
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [UIViewController setHidden:hidden toView:obj];
    } ];
}

- (void)setHidden:(BOOL)hidden toViewsWithKey:(NSString *)key
{
    [self callOnViews:^(NSArray *views) {
        [self setHidden:hidden toViews:views];
    } forKey:key];
}

- (void)setHidden:(BOOL)hidden
          toLabel:(UILabel *)label
        andButton:(UIButton *)button
     andTextField:(UITextField *)textField
      andTextView:(UITextView *)textView
{
    [self setHidden:hidden
            toViews:[NSArray arrayOfLabel:label andButton:button andTextField:textField andTextView:textView] ];
}

@end
