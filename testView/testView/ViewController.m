

#import "ViewController.h"




@interface ViewController () {
    BOOL        viewSelected;
}

@property (weak, nonatomic) UITextField *activeField;

@end



@implementation ViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.viewSelf.hidden = YES;
    
    self.textField1Ib.delegate = self;
    self.textField2Ib.delegate = self;
    
    //CGRect contentRect = CGRectZero;
    //for (UIView *view in self.scrollViewIb.subviews) {
        //contentRect = CGRectUnion(contentRect, view.frame);
    //}
    
    //self.scrollViewIb.contentSize = contentRect.size;
    self.scrollViewIb.scrollEnabled = false;
    
    // main scrollView
    CGRect mcontentRect = CGRectZero;
    for (UIView *view in self.mainScrollViewIb.subviews) {
        mcontentRect = CGRectUnion(mcontentRect, view.frame);
    }
    self.mainScrollViewIb.contentSize = mcontentRect.size;
    self.mainScrollViewIb.scrollEnabled = false;
    
    viewSelected = FALSE;
    
    self.textField1Ib.delegate = self;
    self.textField2Ib.delegate = self;
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton action method

- (IBAction)buttonAction:(id)sender {
    
    self.viewSelf.hidden = NO;
    self.viewSelf.frame = CGRectMake(((self.view.frame.size.width / 2.0f) - (350 / 2.0f)), ((self.view.frame.size.height / 2.0f) - (450 / 2.0f)), 350, 450);
    [self.view addSubview:self.viewSelf];
    
    viewSelected = TRUE;
}

- (IBAction)cancelAction:(id)sender {
    
    viewSelected = FALSE;
    self.viewSelf.hidden = YES;
    [self.viewSelf removeFromSuperview ];
}

#pragma mark - Text Field Delegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.activeField = textField;
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIScrollView delegate methods

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollViewIb.scrollEnabled = false;
    self.mainScrollViewIb.scrollEnabled = false;
}

#pragma mark - keyboard notification method

- (void) keyboardDidShow:(NSNotification *)notification {
    
    if (viewSelected) {
        
        self.scrollViewIb.scrollEnabled = true;
        
        NSDictionary* info = [notification userInfo];
        CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        // If you are using Xcode 6 or iOS 7.0, you may need this line of code. There was a bug when you
        // rotated the device to landscape. It reported the keyboard as the wrong size as if it was still in portrait mode.
        //kbRect = [self.view convertRect:kbRect fromView:nil];
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
        self.scrollViewIb.contentInset = contentInsets;
        self.scrollViewIb.scrollIndicatorInsets = contentInsets;
        
        CGRect aRect = self.viewSelf.frame;
        //aRect.size.height = aRect.size.height + (self.view.center.y + (450.0f/2));
        aRect.size.height -= kbRect.size.height;
        //CGRect frame = [self.viewSelf convertRect:self.activeField.frame toView:self.viewSelf.superview];
        //CGRect keyframe = [self.view convertRect:aRect toView:self.view];
        //CGRect frame1 = [self.activeField convertRect:self.activeField.frame toView:self.view];
        CGRect frame = [self.scrollViewIb convertRect:self.activeField.frame toView:self.view];
//        if (frame1.origin.y > aRect.origin.y) {
//            NSInteger diff = keyframe.origin.y - frame1.origin.y;
//            [self.scrollViewIb setContentOffset:CGPointMake(0.0, -diff)];
//        }
        if (!CGRectContainsPoint(aRect, frame.origin) ) {
            [self.scrollViewIb scrollRectToVisible:frame animated:YES];
        }
        
    } else {
        
        self.mainScrollViewIb.scrollEnabled = true;
        
        NSDictionary* info = [notification userInfo];
        CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        // If you are using Xcode 6 or iOS 7.0, you may need this line of code. There was a bug when you
        // rotated the device to landscape. It reported the keyboard as the wrong size as if it was still in portrait mode.
        //kbRect = [self.view convertRect:kbRect fromView:nil];
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
        self.mainScrollViewIb.contentInset = contentInsets;
        self.mainScrollViewIb.scrollIndicatorInsets = contentInsets;
        
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbRect.size.height;
        if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
            [self.mainScrollViewIb scrollRectToVisible:self.activeField.frame animated:YES];
        }
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification {
    
    if (viewSelected) {
        
        self.scrollViewIb.scrollEnabled = true;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.scrollViewIb.scrollIndicatorInsets = contentInsets;
        [self.scrollViewIb setContentOffset:CGPointZero animated:false];
        
    } else {
        
        self.mainScrollViewIb.scrollEnabled = true;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.mainScrollViewIb.scrollIndicatorInsets = contentInsets;
        [self.mainScrollViewIb setContentOffset:CGPointZero animated:false];
    }
}

#pragma mark - dealloc method

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


