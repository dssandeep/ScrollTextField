

#import <UIKit/UIKit.h>




@interface ViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonIb;
@property (weak, nonatomic) IBOutlet UITextField *testFieldIb;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollViewIb;
@property (weak, nonatomic) IBOutlet UIView *mainViewSelf;


@property (strong, nonatomic) IBOutlet UIView *viewSelf;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewIb;
@property (weak, nonatomic) IBOutlet UIView *popupViewIb;
@property (weak, nonatomic) IBOutlet UITextField *textField1Ib;
@property (weak, nonatomic) IBOutlet UITextField *textField2Ib;
@property (weak, nonatomic) IBOutlet UIButton *cancelView;


- (IBAction)buttonAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end

