

####This is a free version of rich text editor. These features are available only in paid version 
 
 1. Native find and replace.
 
 2. Editing font size and font family properties.

The full version is available on 

http://www.chupamobile.com/ios-frameworks-libraries/ios-richtext-editor-8250 

//------------------------------------------------------------------------------------------------

####REQUIREMENTS----


1. iOS 7 or later.

2. Best suited for portrait.

//------------------------------------------------------------------------------------------------

####HOW TO ADD IN YOUR PROJECT----


STEP 1. Copy CustomTextView folder to your app.

STEP 2. Import  #import "CustomTextView.h"

                in your view controller.
                
STEP 3.  Call the constructor. eg. CustomTextView *customTextView=[[CustomTextView alloc]initWithView:view withViewController:self];
    
    Here the view is in which CustomTextView is to be set.
    
STEP 4. Add CustomTextView to your view eg. [view addSubview:customTextView];
    
STEP 5. Set customTextView's delegates to self
    
    Eg. customTextView.customDelegate=self;


//------------------------------------------------------------------------------------------------


####HOW TO SAVE WHEN EDITING IS DONE--


STEP 1. Call the function "saveWithFileName". 

Eg. [customTextView saveWithFileName:@"user_1"];

// filename should be unique.

Function will give callback (below mentioned delegate calls).

STEP 2. Register for these delegate-

-(void)attributedTextFileNotSavedWithError;

-(void)fileSaved;


//------------------------------------------------------------------------------------------------

####HOW TO SHOW EDITED TEXT--


STEP 1. Call the function "setAttributedTextwithfileName" to set attributed text on CustomCustomTextView.

Eg.  [customTextView  setAttributedTextwithfileName@"user_1"]; // filename same as while saving


//------------------------------------------------------------------------------------------------

####DELEGATES--


1. -(void)attributedTextFileNotSavedWithError:(NSError *)error;

// if attributed text file not saved to local path.

2. -(void)errorWhileReadingAttributedTextFile:(NSError *)error;

// error while converting content of attributed text file to nsdata.

3. -(void)fileDoesNotExistAtPath:(NSString *)path;

// attributed text file not exist at path.

4. -(void)fileSaved;

// attributed text file saved successfully


//------------------------------------------------------------------------------------------------

####NOTES---


1. Trackpad works idealy when text is in good quantity.

2. To remove attributes applied while finding or replacing "DOUBLE-TAP" on textview or click find button again.


//------------------------------------------------------------------------------------------------

####BUTTON SPECIFICATIONS---

Bold,
Italic,
Underline,
Align left,
Align center,
Align right,
Font color,
Background color,
Search on web,
Trackpad(move finger on keyboard to move cursor on textview i.e. similar to trackpad in mac's),
Keyboard down,
Font size and family (In paid version),
Native search and replace (In paid version).

//------------------------------------------------------------------------------------------------


