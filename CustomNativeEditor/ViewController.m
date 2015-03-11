//
//  ViewController.m
//  CustomNativeEditor
//
//  Created by Medma Infomatix on 11/02/15.
//  Copyright (c) 2015 Medma Infomatix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize customTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    customTextView=[[CustomTextView alloc]initWithView:new_view withViewController:self];
    
    //add textview to your view
    
    // set deault text if needed from customtextview.m in "setAttributedTextwithfileName" function.
    
    [new_view addSubview:customTextView];
    
    //set delegate...
    
    customTextView.customDelegate=self;
    
    // set attributed text on textview...
    
    [customTextView   setAttributedTextwithfileName:@"user1"]; // filename should be according to name given while saving.
   
}

//------------------------------------------------------------------------------------------------

-(IBAction)saveBtnClicked:(id)sender
{
    // call when text is to be saved..
    
    [customTextView saveWithFileName:@"user1"];
    
}

//==========================================================

#pragma mark-- CustomTextView Delegates..

//==========================================================


-(void)fileSaved
{
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:nil message:@"Saved" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [av show];
    
    NSLog(@"File saved successfully");
}

//------------------------------------------------------------------------------------------------


-(void)attributedTextFileNotSavedWithError:(NSError *)error
{
    NSLog(@"Attributed Text File Not Saved With Error---- %@",error);
}

//------------------------------------------------------------------------------------------------

-(void)errorWhileReadingAttributedTextFile:(NSError *)error
{
    NSLog(@"Error While Reading AttributedTextFile is--- %@",error);
    
}

//------------------------------------------------------------------------------------------------

-(void)fileDoesNotExistAtPath:(NSString *)path
{
    // will give callback if you have not saved any file yet or running for the first time..else in case of error
    
    NSLog(@"file do not exist at path----- %@",path);
    
}

//------------------------------------------------------------------------------------------------

@end
