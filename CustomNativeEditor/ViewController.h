//
//  ViewController.h
//  CustomNativeEditor
//
//  Created by Medma Infomatix on 11/02/15.
//  Copyright (c) 2015 Medma Infomatix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"


@interface ViewController : UIViewController<UITextViewDelegate,CustomTextViewProtocols>
{
    
    IBOutlet UIButton *saveBtn;
    IBOutlet UIView *new_view;
     
    
}

-(IBAction)saveBtnClicked:(id)sender;

@property(nonatomic,strong) CustomTextView *customTextView;

@end
