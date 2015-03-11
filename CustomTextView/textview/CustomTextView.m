//
//  CustomTextView.m
//  CustomNativeEditor
//
//  Created by Medma Infomatix on 11/02/15.
//  Copyright (c) 2015 Medma Infomatix. All rights reserved.
//

#import "CustomTextView.h"


//---------------------------------------------------------------------------------

@implementation CustomTextView

@synthesize customDelegate;

//-----------------------------PARAMETERS----------------------------------------------------

// superview - Give the view in which you want to setup textview..

//viewController - your view controller..

-(instancetype)initWithView:(UIView *)superView withViewController:(UIViewController *)viewController
{
    self=[super initWithFrame:CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height)];

    if(self)
    {
        
        // set textview default font name and size..
        
        [self setFont:[UIFont fontWithName:DEFAULT_FONT_NAME size:DEFAULT_FONT_SIZE]];
        
        customView=superView;
        
        customViewController=viewController;
        
        // set toolbar on keyboard..
                
        [self setToolBarOnKeyBoard];
        
        // set textview delegate..
        
        self.delegate=self;
                
        [self setNotifications];
        
    }
    
    return self;
    
}

//--------------------------------------------------------------------------------

-(void)setNotifications
{
    // register for keyboard notifications..
    
    [self setKeyBoardNotification];
    
}

//=================================================================================
#pragma mark--- set attributed text
//=================================================================================

-(void)setAttributedTextwithfileName:(NSString *)fileName
{
    // get path of file stored at app's local path..
    
    NSString *textFilePath=[[NSMutableString alloc] initWithString:[self getPathForRetrivingFile:fileName]];

    // check if file exist at path or not..
    
   BOOL isfileExist= [[NSFileManager defaultManager] fileExistsAtPath:textFilePath];
    
    NSError* error = nil;
    
    // get attributed text from file..
    
    if (isfileExist)
    {
       
        NSData *text_data = [NSData dataWithContentsOfFile:textFilePath options: 0 error: &error];
        
        if (error != nil)
        {
            // notify for error while getting data from file..
            
            if ([customDelegate respondsToSelector:@selector(errorWhileReadingAttributedTextFile:)])

            {
                [customDelegate errorWhileReadingAttributedTextFile:error];
                
            }
        }
        
        else
        {
            
            // set saved text...
            
        NSMutableAttributedString *saved_text =[[NSKeyedUnarchiver unarchiveObjectWithData:text_data] mutableCopy];
        
            self.attributedText=saved_text;

        }
        
    }
    
    else
    {
        // notify that file is not present at local path.. will also notify when running first time..
        
        if ([customDelegate respondsToSelector:@selector(fileDoesNotExistAtPath:)])
        {
            
            [customDelegate fileDoesNotExistAtPath:textFilePath];
        
        }
        // set text when app loads for first time i.e. when no text is saved.. set your default text..
        
        self.text=@"medma medma demo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text editor demo custom text editor demo custom textmo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text demo custom textmedma medma demo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text editor demo custom text editor demo custom textmo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text demo custom textmedma medma demo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text editor demo custom text editor demo custom textmo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text demo custom textmedma medma demo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text editor demo custom text editor demo custom textmo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text demo custom textmedma medma demo demo demo demo demo demo demo demo demo custom text editor demo medma medma demo demo demo demo demo demo demo demo demo custom text editor demo custom text editor demo custom text editor demo custom textmo demo demo demo demo demo demo demo demo custom text editor demo medma";
        
        }
    
    
}

//===============================================================================
#pragma  mark-- set layout
//===============================================================================

-(void)setToolBarOnKeyBoard
{
    // initialization of views on keyboard's toolbar and set their frames..
    
    toolbar = [[UIToolbar alloc]init];
    
    toolbar_scrolvw=[[UIScrollView alloc]init];
    
    toolbar_scrolvw.showsHorizontalScrollIndicator=NO;
    
    [toolbar_scrolvw setFrame:CGRectMake(0, 0, customViewController.view.frame.size.width, 44)];
    
    [self setFrame:CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height)];
   
    [toolbar addSubview:toolbar_scrolvw];
    
    //initialize and set frame of bold button
    
    UIButton *bold_btn=[[UIButton alloc]initWithFrame:CGRectMake(VERTICAL_SPACING,0,(toolbar_scrolvw.frame.size.height/1.2)*1.7,toolbar_scrolvw.frame.size.height/1.2)];
    
    // set action
    
    [bold_btn addTarget:self action:@selector(bold:) forControlEvents:UIControlEventTouchUpInside];
    
    // set image
    
    [bold_btn setImage:TEXT_BOLD_IMAGE forState:UIControlStateNormal];

    // set button in center(y).
    
    bold_btn.center=[self getYCenterPointsForUIView:bold_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of italic button
    
    UIButton *italic_btn=[[UIButton alloc]initWithFrame:CGRectMake(bold_btn.frame.origin.x+bold_btn.frame.size.width+VERTICAL_SPACING, 0, (toolbar_scrolvw.frame.size.height/1.2)*1.7 ,toolbar_scrolvw.frame.size.height/1.2)];
    
    [italic_btn addTarget:self action:@selector(italic:) forControlEvents:UIControlEventTouchUpInside];
    
    [italic_btn setImage:TEXT_ITALIC_IMAGE forState:UIControlStateNormal];
    
    
    italic_btn.center=[self getYCenterPointsForUIView:italic_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of underline button
    
    UIButton *underLine_btn=[[UIButton alloc]initWithFrame:CGRectMake(italic_btn.frame.origin.x+italic_btn.frame.size.width+VERTICAL_SPACING,  0, (toolbar_scrolvw.frame.size.height/1.2)*1.7 , toolbar_scrolvw.frame.size.height/1.2)];
    
    [underLine_btn addTarget:self action:@selector(underLine:) forControlEvents:UIControlEventTouchUpInside];
    
    [underLine_btn setImage:TEXT_UNDERLINE_IMAGE forState:UIControlStateNormal];
    
    underLine_btn.center=[self getYCenterPointsForUIView:underLine_btn InView:toolbar_scrolvw];

    
    //initialize and set frame of align left button
    
    UIButton *align_left_btn=[[UIButton alloc]initWithFrame:CGRectMake(underLine_btn.frame.origin.x+underLine_btn.frame.size.width+VERTICAL_SPACING, 0, (toolbar_scrolvw.frame.size.height/1.2)*1.7,toolbar_scrolvw.frame.size.height/1.2)];
    
    [align_left_btn addTarget:self action:@selector(alignLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    [align_left_btn setImage:LEFT_ALIGN_IMAGE forState:UIControlStateNormal];

    align_left_btn.center=[self getYCenterPointsForUIView:align_left_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of align center button
    
    UIButton *align_center_btn=[[UIButton alloc]initWithFrame:CGRectMake(align_left_btn.frame.origin.x+align_left_btn.frame.size.width+VERTICAL_SPACING, 0, (toolbar_scrolvw.frame.size.height/1.2)*1.7 ,toolbar_scrolvw.frame.size.height/1.2)];
    
    [align_center_btn addTarget:self action:@selector(alignCenter:) forControlEvents:UIControlEventTouchUpInside];
    
    [align_center_btn setImage:CENTER_ALIGN_IMAGE forState:UIControlStateNormal];
    
    align_center_btn.center=[self getYCenterPointsForUIView:align_center_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of align right button
    
    UIButton *align_right_btn=[[UIButton alloc]initWithFrame:CGRectMake(align_center_btn.frame.origin.x+align_center_btn.frame.size.width+VERTICAL_SPACING,  0,(toolbar_scrolvw.frame.size.height/1.2)*1.7 , toolbar_scrolvw.frame.size.height/1.2)];
    
    [align_right_btn addTarget:self action:@selector(alignRight:) forControlEvents:UIControlEventTouchUpInside];
    
    [align_right_btn setImage:RIGHT_ALIGN_IMAGE forState:UIControlStateNormal];
    
    align_right_btn.center=[self getYCenterPointsForUIView:align_right_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of font color button
    
    UIButton *fontcolor_btn=[[UIButton alloc]initWithFrame:CGRectMake(align_right_btn.frame.origin.x+align_right_btn.frame.size.width+VERTICAL_SPACING,  0,(toolbar_scrolvw.frame.size.height/1.2)*1.7,toolbar_scrolvw.frame.size.height/1.2)];
    
    [fontcolor_btn addTarget:self action:@selector(fontColor:) forControlEvents:UIControlEventTouchUpInside];
    
    [fontcolor_btn setImage:TEXT_COLOR_IMAGE forState:UIControlStateNormal];
    
    fontcolor_btn.center=[self getYCenterPointsForUIView:fontcolor_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of background color button
    
    UIButton *backcolor_btn=[[UIButton alloc]initWithFrame:CGRectMake(fontcolor_btn.frame.origin.x+fontcolor_btn.frame.size.width+VERTICAL_SPACING,  0, (toolbar_scrolvw.frame.size.height/1.2)*1.7 , toolbar_scrolvw.frame.size.height/1.2)];
    
    [backcolor_btn addTarget:self action:@selector(backgroundColor:) forControlEvents:UIControlEventTouchUpInside];
    
    [backcolor_btn setImage:BACKGROUND_COLOR_IMAGE forState:UIControlStateNormal];
    
    backcolor_btn.center=[self getYCenterPointsForUIView:backcolor_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of web search button
    
    UIButton *web_search_btn=[[UIButton alloc]initWithFrame:CGRectMake(backcolor_btn.frame.origin.x+backcolor_btn.frame.size.width+VERTICAL_SPACING,  0, (toolbar_scrolvw.frame.size.height/1.2)*1.7,toolbar_scrolvw.frame.size.height/1.2)];
    
    [web_search_btn addTarget:self action:@selector(webSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    [web_search_btn setImage:WEB_SEARCH_IMAGE forState:UIControlStateNormal];
    
    web_search_btn.center=[self getYCenterPointsForUIView:web_search_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of trackpad button
    
    UIButton *track_pad_btn=[[UIButton alloc]initWithFrame:CGRectMake(web_search_btn.frame.origin.x+web_search_btn.frame.size.width+VERTICAL_SPACING,  0, (toolbar_scrolvw.frame.size.height/1.2)*1.7 , toolbar_scrolvw.frame.size.height/1.2)];
    
    [track_pad_btn addTarget:self action:@selector(trackPad:) forControlEvents:UIControlEventTouchUpInside];
    
    [track_pad_btn setImage:TRACKPAD_DISABLED_IMAGE forState:UIControlStateNormal];
    
    
    track_pad_btn.center=[self getYCenterPointsForUIView:track_pad_btn InView:toolbar_scrolvw];
    track_pad_btn.tag=1;
    
    //initialize and set frame of keyboard button
    
    UIButton *keyBoardDown_btn=[[UIButton alloc]initWithFrame:CGRectMake(track_pad_btn.frame.origin.x+track_pad_btn.frame.size.width+VERTICAL_SPACING,  0, (toolbar_scrolvw.frame.size.height/1.2)*1.7 , toolbar_scrolvw.frame.size.height/1.2)];
    
    [keyBoardDown_btn addTarget:self action:@selector(keyBoardDown:) forControlEvents:UIControlEventTouchUpInside];
    
    [keyBoardDown_btn setImage:KEYBOARD_DOWN_IMAGE forState:UIControlStateNormal];
    
    keyBoardDown_btn.center=[self getYCenterPointsForUIView:keyBoardDown_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of edit font property button
    
    UIButton *edit_font_size_btn=[[UIButton alloc]initWithFrame:CGRectMake(keyBoardDown_btn.frame.origin.x+keyBoardDown_btn.frame.size.width+VERTICAL_SPACING, 0, (toolbar_scrolvw.frame.size.height/1.2)*1.7,toolbar_scrolvw.frame.size.height/1.2)];
    
    [edit_font_size_btn addTarget:self action:@selector(editFontSize:) forControlEvents:UIControlEventTouchUpInside];
    
    [edit_font_size_btn setImage:EDIT_FONT_SIZE_IMAGE forState:UIControlStateNormal];
    
    edit_font_size_btn.center=[self getYCenterPointsForUIView:edit_font_size_btn InView:toolbar_scrolvw];
    
    //initialize and set frame of local find button
    
    UIButton *find_btn=[[UIButton alloc]initWithFrame:CGRectMake(edit_font_size_btn.frame.origin.x+edit_font_size_btn.frame.size.width+VERTICAL_SPACING,  0, (toolbar_scrolvw.frame.size.height/1.2)*1.7,toolbar_scrolvw.frame.size.height/1.2)];
    
    [find_btn addTarget:self action:@selector(find:) forControlEvents:UIControlEventTouchUpInside];
    
    [find_btn setImage:TEXT_SEARCH_IMAGE forState:UIControlStateNormal];
    
    find_btn.center=[self getYCenterPointsForUIView:find_btn InView:toolbar_scrolvw];

    //add all buttons to toolbar's scrollview..
    
    NSArray *buttons_array=[[NSArray alloc]initWithObjects:bold_btn,italic_btn,underLine_btn,align_left_btn,align_center_btn,align_right_btn,fontcolor_btn,backcolor_btn,web_search_btn,track_pad_btn,keyBoardDown_btn,edit_font_size_btn,find_btn, nil];
    
    for (UIButton *button in buttons_array)
    {
        // add button as subview..
        
        [toolbar_scrolvw addSubview:button];
        
        
    }
    
    // get last button on toolbar to set scrollview's content size..
    
    UIButton *lstBtn=[[UIButton alloc]init];
    
    lstBtn=[toolbar_scrolvw.subviews lastObject];
        
    //set content size of toolbar's scrollview from the last button position on it..
    
    toolbar_scrolvw.contentSize=CGSizeMake(lstBtn.frame.size.width+lstBtn.frame.origin.x+VERTICAL_SPACING, toolbar.frame.size.height);
    
    [toolbar sizeToFit];
    
    //assign toolbar to custom textview..
    
    self.inputAccessoryView = toolbar;

}

//--------------------------------------------------------------------------------

// get center point w.r.t 'Y' co-ordinate in container view.

-(CGPoint)getYCenterPointsForUIView:(UIView *)view InView:(UIView *)containerView
{
    CGPoint point=view.center;
    
    point.y=containerView.center.y;
    
    return point;
    
}

//--------------------------------------------------------------------------------

// get center point w.r.t 'X' co-ordinate in container view.

-(CGPoint)getXCenterPointsForUIView:(UIView *)view InView:(UIView *)containerView
{
    CGPoint point=view.center;
    
    point.x=containerView.center.x;
    
    return point;
    
}

//================================================================================
#pragma mark-- keyboard down
//================================================================================

// resign first responder..

-(void)keyBoardDown:(id)sender
{
     [self removeTrackpad];
    
    [self resignFirstResponder];
    
}

//================================================================================
#pragma mark-- Web search
//================================================================================

// search on web for the selected text..

-(void)webSearch:(id)sender
{
    
    NSString *stringToSearch=[self getSelectedTextFromTextView];
    
    if (![stringToSearch isEqualToString:@""])
    {
        
        NSString *googleUrl=[NSString stringWithFormat:@"%@%@",
                                                        GOOGLE_URL,[stringToSearch  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
          NSURL *url = [NSURL URLWithString:googleUrl];
        
        
        [[UIApplication sharedApplication] openURL:url];

    }
    
    else
    {
    // show alert if nothings is selected to search..
        
        UIAlertView *unselected_av=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"provide_search_word", nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        
        [unselected_av show];
        
    }
    
}

//--------------------------------------------------------------------------------

// gives selected text of textview..

-(NSString *)getSelectedTextFromTextView
{
    NSRange range = [self selectedRange];
    NSString *string = [self.text substringWithRange:range];
    
    return string;
    
}

//===================================
#pragma mark-- back & fore color
//===================================

// set background color of selected text..

-(void)backgroundColor:(id)sender
{
    [self removeTrackpad];
    
    if ([self isSelectedRangeNil])
    {
    
        InfColorPickerController* picker = [InfColorPickerController colorPickerViewController];
	
        picker.sourceColor = customViewController.view.backgroundColor;
        
        picker.delegate = self;
        
        picker.title=NSLocalizedString(@"back_color", nil);
        
        [picker presentModallyOverViewController: customViewController];
        
    }
}

//---------------------------------------------------------------------------------

// set foreground color of selected text..

-(void)fontColor:(id)sender
{
    [self removeTrackpad];
 
    if ([self isSelectedRangeNil])
    {
        
        InfColorPickerController* picker = [InfColorPickerController colorPickerViewController];
        
        picker.sourceColor = customViewController.view.backgroundColor;
        
        picker.delegate = self;
        
        picker.title=NSLocalizedString(@"font_color", nil);
        
        [picker presentModallyOverViewController: customViewController];

    }
    
}

//=================================================================================
#pragma mark-- color picker delegate
//=================================================================================

- (void)colorPickerControllerDidFinish: (InfColorPickerController*) picker
{
    NSMutableDictionary *colordic =[[NSMutableDictionary alloc]init];
    
    NSRange selectedRange = [self selectedRange];

    // if background color button is clicked

    if ([picker.title isEqualToString:NSLocalizedString(@"back_color", nil)]) {
        
        
        [colordic setValue:picker.resultColor
                        forKey:NSBackgroundColorAttributeName];
        
    
    }
    
    // if font color button is clicked
    
    if ([picker.title isEqualToString:NSLocalizedString(@"font_color", nil)])
    {
        [colordic setValue:picker.resultColor
                    forKey:NSForegroundColorAttributeName];

    }
    
    // set color attriubte on selected text..
    
    [self.textStorage beginEditing];
    
    [self.textStorage addAttributes:colordic range:selectedRange];
    
    [self.textStorage endEditing];
    
    // dismiss color picker when color is picked
    
    [customViewController dismissViewControllerAnimated:YES completion:nil];
    
    
}

//---------------------------------------------------------------------------------

// do not select any color.. resign color pallet(picker).

- (void) colorPickerCancelButtonClicked:(InfColorPickerController *)controller
{
    
    [customViewController dismissViewControllerAnimated:YES completion:nil];
    
}

//=================================================================================
#pragma mark-- set trackpad
//=================================================================================

// feature works idealy when text is more..

// add trackpad to keyboard..

-(void)trackPad:(id)sender
{
    UIButton *btn=((UIButton *)sender);

    if (btn.tag==1)
    {
        // get keyboard
        
        UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:1];
        
        CGFloat y=[UIScreen mainScreen].bounds.size.height;
        
        //y is height of keyboard..
        
        y=(y-kbSize.height);
        
        
        keyboardScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,y+toolbar.frame.size.height, kbSize.width, kbSize.height)];
        
        keyboardScrollView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        // set view to display trackpad info image
        
        UIView *infoLabel=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, keyboardScrollView.frame.size.width/1.2, keyboardScrollView.frame.size.height/4)];
        
        UIImageView *image_view=[[UIImageView alloc]initWithFrame:CGRectMake(0, (infoLabel.frame.origin.y+infoLabel.frame.size.height)-(30+infoLabel.frame.size.height/1.3)-10, infoLabel.frame.size.width/1.2, infoLabel.frame.size.height/1.3)];
        
        // display trackpad info image
        
        image_view.center=[self getXCenterPointsForUIView:image_view InView:infoLabel];
        
        image_view.image=TRACKPAD_INFO_IMAGE;
        
        infoLabel.layer.cornerRadius = 5.0;
        
        infoLabel.clipsToBounds=YES;
        
        infoLabel.center=[self getXCenterPointsForUIView:infoLabel InView:keyboardScrollView];
        
        infoLabel.backgroundColor=[UIColor whiteColor];
       
        // add subviews..
        
        [infoLabel addSubview:image_view];
        
        [keyboardScrollView addSubview:infoLabel];
   
        // info image animates..
        
        [UIView animateWithDuration:4 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                              [infoLabel setAlpha:0];
                         } completion:^(BOOL finished) {
                             
                         }];
        
        keyboardScrollView.contentSize=self.contentSize;
    
        // override keyboard's view with keyboard scrollview..
        
        [win insertSubview:keyboardScrollView
                   atIndex:win.subviews.count+1];
        
        // set guesture recognizer on keyboard's scrollview
        
        UIPanGestureRecognizer *swipeReg=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        
        [keyboardScrollView addGestureRecognizer:swipeReg];
        
        keyboardScrollView.tag=KEYBOARD_SCROLLVIEW_TAG;
        
        // indicate trackpad is enabled
        
        [btn setImage:TRACKPAD_ENABLED_IMAGE forState:UIControlStateNormal];
        
        btn.tag=2;
        
    }
    
    else
    {
        [self removeTrackpad];
        
    }

}

//---------------------------------------------------------------------------------

//removes trackpad feature from keyboard..

-(void)removeTrackpad
{
    UIButton *tp_btn=(UIButton *)[toolbar_scrolvw viewWithTag:2];
    
    UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:1];
    
    UIScrollView *keybrd_scrlvw=(UIScrollView *)[win viewWithTag:KEYBOARD_SCROLLVIEW_TAG];
    
    [keybrd_scrlvw removeFromSuperview];
    
    // indicate trackpad is disabled
    
    [tp_btn setImage:TRACKPAD_DISABLED_IMAGE forState:UIControlStateNormal];
    
    tp_btn.tag=1;
    
}

//---------------------------------------------------------------------------------

// pan guesture selector

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIImageView *moveUpImage;
    
    UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:1];
    
    UIView *kb=[win viewWithTag:KEYBOARD_SCROLLVIEW_TAG];
    
    CGPoint point = [recognizer locationInView:kb];
        
    NSUInteger index = [self.layoutManager characterIndexForPoint:point inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (point.y <= self.contentSize.height && !(point.y < 0))
    {
        
        // make textview's text visible where cursor points..
            
        [self setContentOffset:CGPointMake(0, point.y-100) animated:YES];
        
        // set contentoffset of keyboard scrollview same as textview contentoffset..
        
        [keyboardScrollView setContentOffset:CGPointMake(0, point.y) animated:YES];
        
        //set cursor position
        
        self.selectedRange = NSMakeRange(index, 0);
        

           
    }
    
    else
    {
        //show image to move up on reaching textview's bottom..
        
        moveUpImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, (keyboardScrollView.frame.origin.y+keyboardScrollView.contentSize.height)-(kbSize.height),(kbSize.width/1.2),(kbSize.height/3.5))];
        
         moveUpImage.center=[self getXCenterPointsForUIView:moveUpImage InView:keyboardScrollView];
        
        moveUpImage.image=TRACKPAD_MOVEUP_IMAGE;
        
        moveUpImage.alpha=1;
        
        moveUpImage.layer.cornerRadius = 5.0;
        
        moveUpImage.clipsToBounds=YES;
        
        [keyboardScrollView addSubview:moveUpImage];
    }
    
}
//================================================================================
#pragma mark-- set keyboard notification
//================================================================================

// register for keyboard notifications..

-(void)setKeyBoardNotification
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
}

//--------------------------------------------------------------------------------

-(void)keyboardShown:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
	
    //store keyboard size for further use..
    
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
}


//================================================================================
#pragma mark-- bold & italic function
//================================================================================

-(void)bold:(id)sender
{
    // get range of selected text in textview
    
   NSRange selectedRange = [self selectedRange];
    
    // check if user have selected text or not..
    
    if ([self isSelectedRangeNil])
    {
        [self addOrRemoveFontTraitWithName:NSLocalizedString(@"Bold", nil) andValue:UIFontDescriptorTraitBold withRange:selectedRange];
    }
    
}

//--------------------------------------------------------------------------------

// makes text italic...

-(void)italic:(id)sender
{
    NSRange selectedRange = [self selectedRange];
    
    if ([self isSelectedRangeNil])
    {
        [self addOrRemoveFontTraitWithName:NSLocalizedString(@"Italic", nil) andValue:UIFontDescriptorTraitItalic withRange:selectedRange];
    }
}

//--------------------------------------------------------------------------------

// makes text bold or italic

-(void)addOrRemoveFontTraitWithName:(NSString *)traitName andValue:(uint32_t)traitValue withRange:(NSRange)selectedRange {
    
    NSMutableDictionary *traitDic=[[NSMutableDictionary alloc]init];
    
    
    NSDictionary *currentAttributesDict = [self.textStorage attributesAtIndex:selectedRange.location
                                                                    effectiveRange:nil];
    
    
    UIFont *currentFont = [currentAttributesDict objectForKey:NSFontAttributeName];
    
    UIFontDescriptor *fontDescriptor = [currentFont fontDescriptor];
    
    NSString *fontNameAttribute = [[fontDescriptor fontAttributes] objectForKey:UIFontDescriptorNameAttribute];
    UIFontDescriptor *changedFontDescriptor;
    
    if ([fontNameAttribute rangeOfString:traitName].location == NSNotFound)
    {
        uint32_t existingTraitsWithNewTrait = [fontDescriptor symbolicTraits] | traitValue;
        changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:existingTraitsWithNewTrait];
    }
    
      // if text is already bold/italic then remove bold/italic property
    
    else{
        uint32_t existingTraitsWithoutTrait = [fontDescriptor symbolicTraits] & ~traitValue;
        
        
        changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:existingTraitsWithoutTrait];
    }
    
    //apply final attribiutes..
    
    UIFont *updatedFont = [UIFont fontWithDescriptor:changedFontDescriptor size:0.0];
    
    [traitDic setValue:updatedFont forKey:NSFontAttributeName];
    
    [self addAttributesWithDic:traitDic forRange:selectedRange];
    
}

//================================================================================
#pragma mark-- underline function
//================================================================================

-(void)underLine:(id)sender
{

    NSRange selectedRange = [self selectedRange];
    
    if ([self isSelectedRangeNil])
    {
       [self underlineWithrange:selectedRange];
    }
}

//--------------------------------------------------------------------------------

// makes text underline if not & vice versa..

-(void)underlineWithrange:(NSRange)selectedRange
{
    
    NSDictionary *currentAttributesDict = [self.textStorage attributesAtIndex:selectedRange.location
                                                                    effectiveRange:nil];
    
    UIFont *currentFont = [currentAttributesDict objectForKey:NSFontAttributeName];
    
    UIFontDescriptor *fontDescriptor = [currentFont fontDescriptor];
    
    UIFontDescriptor *changedFontDescriptor;
    
    NSMutableDictionary *underLineDic=[[NSMutableDictionary alloc] init];
    
    if ([currentAttributesDict objectForKey:NSUnderlineStyleAttributeName] == nil ||
        [[currentAttributesDict objectForKey:NSUnderlineStyleAttributeName] intValue] == 0) {
        
        uint32_t existingTraitsWithNewTrait = [fontDescriptor symbolicTraits];
        changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:existingTraitsWithNewTrait];
        
        
        UIFont *updatedFont = [UIFont fontWithDescriptor:changedFontDescriptor size:0.0];
        

        [underLineDic setValue:updatedFont forKey:NSFontAttributeName];
        [underLineDic setValue:[NSNumber numberWithInt:1] forKey:NSUnderlineStyleAttributeName];
        
        
    }
    
    else{
        uint32_t existingTraitsWithNewTrait = [fontDescriptor symbolicTraits];
        changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:existingTraitsWithNewTrait];
        
        UIFont *updatedFont = [UIFont fontWithDescriptor:changedFontDescriptor size:0.0];
        
        [underLineDic setValue:updatedFont forKey:NSFontAttributeName];
        [underLineDic setValue:[NSNumber numberWithInt:0] forKey:NSUnderlineStyleAttributeName];
    }
    
    [self addAttributesWithDic:underLineDic forRange:selectedRange];

}

//================================================================================
#pragma mark-- set font size
//================================================================================

// setup UI for font editing option...

-(void)editFontSize:(id)sender
{
    
    // oops! upgrade for full version...
    
}

//=================================================================================
#pragma mark-- set paragraph alignment functions
//=================================================================================


-(void)alignLeft:(id)sender
{
    NSRange selectedRange = [self selectedRange];
    
    if ([self isSelectedRangeNil])
    {
        [self setParagraphAlignment:NSTextAlignmentLeft WithRange:selectedRange WithKey:NSLocalizedString(@"AlignLeft", nil)];

    }
    
    
}

//---------------------------------------------------------------------------------

-(void)alignCenter:(id)sender
{
    NSRange selectedRange = [self selectedRange];
    
    
    if ([self isSelectedRangeNil])
    {
    
        [self setParagraphAlignment:NSTextAlignmentCenter WithRange:selectedRange WithKey:NSLocalizedString(@"AlignCenter", nil)];
    }
    
}

//---------------------------------------------------------------------------------

-(void)alignRight:(id)sender
{
    NSRange selectedRange = [self selectedRange];
    
    
    if ([self isSelectedRangeNil])
    {
    
        [self setParagraphAlignment:NSTextAlignmentRight WithRange:selectedRange WithKey:NSLocalizedString(@"AlignRight", nil)];
    }
    
}

//---------------------------------------------------------------------------------

-(void)setParagraphAlignment:(NSTextAlignment)newAlignment WithRange:(NSRange)selectedRange WithKey:(NSString *)key
{
    NSMutableDictionary *paraAlignDic=[[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *newParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [newParagraphStyle setAlignment:newAlignment];
    
    [paraAlignDic setValue:newParagraphStyle forKey:NSParagraphStyleAttributeName];
    
    [self addAttributesWithDic:paraAlignDic forRange:selectedRange];
    
}

//=================================================================================
#pragma mark-- find, find & replace function
//=================================================================================

-(void)find:(id)sender
{
    
    // sorry! upgrade to full version..

}

//===============================================================================
#pragma mark-- self delegate
//===============================================================================

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    CGPoint cursorPoint = [self caretRectForPosition:self.selectedTextRange.start].origin;
    
    [keyboardScrollView setContentOffset:CGPointMake(0, cursorPoint.y-100) animated:YES];
    
}

//---------------------------------------------------------------------------------

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}


//===============================================================================
#pragma mark-- save attributes file to local applications path
//===============================================================================

-(void)saveWithFileName:(NSString *)fileName
{
    NSError *error=nil;
    
    // archieve text to data to write in file
    
    NSData *attribute_data = [NSKeyedArchiver archivedDataWithRootObject:self.attributedText];
    
    NSString *attributes_file_path=[[NSMutableString alloc]
                                    initWithString:[self getPathOfLocalAttributeFolderWithFileName:fileName]];

    [attribute_data writeToFile:attributes_file_path options:NSDataWritingAtomic error:&error];
    
    // notify in case of error..
    
    if (error!=nil)
    {
        if ([customDelegate respondsToSelector:@selector(attributedTextFileNotSavedWithError:)])
        {
            
            [customDelegate attributedTextFileNotSavedWithError:error];
            
        }
    }
    
    // notify success..
    
   else
   {
       if ([customDelegate respondsToSelector:@selector(fileSaved)])
       {
           
           [customDelegate fileSaved];
           
       }
   }
    
}

//-------------------------------------------------------------------------------

// make folder named attribute_path in local app's folder and get its path..

-(NSString *)getPathOfLocalAttributeFolderWithFileName:(NSString *)filename
{
    NSError *error;
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory=[paths objectAtIndex:0];
    
	NSString *local_path = [documentDirectory
                            stringByAppendingPathComponent:FOLDER_NAME];
    
    // delete and make fresh folder if already created..
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:local_path])
    {
        [[NSFileManager defaultManager] removeItemAtPath:local_path error:&error];
        [[NSFileManager defaultManager] createDirectoryAtPath:local_path
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
        
        
        
    }
    
    else
    {
        // else make attribute folder at app's local path...
        
        [[NSFileManager defaultManager] createDirectoryAtPath:local_path
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
        
    }
    
    // make whole path to save file..
    
    NSString *attributes_file_path =[NSString stringWithFormat:@"%@/%@_%@",local_path,ATTRIBUTED_TEXT_FILE_NAME,filename];
    
	return attributes_file_path;
    
}

//---------------------------------------------------------------------------------

// get path of saved file..

-(NSString *)getPathForRetrivingFile:(NSString *)fileName
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory=[paths objectAtIndex:0];
    
	NSString *local_path = [documentDirectory
                            stringByAppendingPathComponent:FOLDER_NAME];
    
    
    NSString *attributes_file_path =[NSString stringWithFormat:@"%@/%@_%@",local_path,ATTRIBUTED_TEXT_FILE_NAME,fileName];
    
    return attributes_file_path;
    
}

//---------------------------------------------------------------------------------

// add attributes to text..

-(void)addAttributesWithDic:(NSDictionary *)attDic forRange:(NSRange)range
{
    [self.textStorage beginEditing];
    
    [self.textStorage addAttributes:attDic range:range];
    
    [self.textStorage endEditing];
}

// if nothings selected while applying attribute..

-(BOOL)isSelectedRangeNil
{
    BOOL isSelected=NO;
    
    NSRange selectedRange=[self selectedRange];
    
    if (selectedRange.length==0 || selectedRange.length>self.text.length)
    {
        
        return isSelected;
        
    }
    
    else
    {
        isSelected=YES;
        return isSelected;
    }
    
    
}

//---------------------------------------------------------------------------------


@end
