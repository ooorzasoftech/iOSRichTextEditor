//
//  CustomTextView.h
//  CustomNativeEditor
//
//  Created by Medma Infomatix on 11/02/15.
//  Copyright (c) 2015 Medma Infomatix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfColorPickerController.h"
#import "Macros.h"

//--------------------------------------------------------------

@protocol CustomTextViewProtocols <NSObject>

@optional

-(void)attributedTextFileNotSavedWithError:(NSError *)error;

-(void)errorWhileReadingAttributedTextFile:(NSError *)error;

-(void)fileDoesNotExistAtPath:(NSString *)path;

-(void)fileSaved;

@end

//--------------------------------------------------------------

typedef NS_ENUM(NSUInteger,font_type)
{
    Bold,
    Italic,
    Underline,
    BackgroundColor,
    TextColor,
    AlignLeft,
    AlignRight,
    AlignCenter,
    Nothing,
};

//--------------------------------------------------------------

@interface CustomTextView : UITextView<UIActionSheetDelegate, UITextViewDelegate,UIAlertViewDelegate, UIScrollViewDelegate,InfColorPickerControllerDelegate>
{

    UIView *customView;
    
    UIViewController *customViewController;
    
    UIToolbar *toolbar;
    
    UIScrollView *toolbar_scrolvw;
    
    UIScrollView *keyboardScrollView;
    
    CGSize kbSize;
    
}

//---------------------------------------------------------------------------------

// superview - Give the view in which you want to setup textview..

//viewController - your view controller..

-(instancetype)initWithView:(UIView *)superView
         withViewController:(UIViewController *)viewController;

@property(nonatomic, weak) id <CustomTextViewProtocols> customDelegate;

// save attributed text..

-(void)saveWithFileName:(NSString *)fileName;

//set attributed text on textview..

-(void)setAttributedTextwithfileName:(NSString *)fileName;

//---------------------------------------------------------------------------------


@end
