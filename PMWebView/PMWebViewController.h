//
//  PMWebViewController.h
//  PMWebView
//
//  Created by Paola Mata Maldonado on 7/21/14.
//
//

#import <UIKit/UIKit.h>

@interface PMWebViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate>{
  
    IBOutlet UITextField *urlTextField;
}

@property (strong, nonatomic)  IBOutlet UIWebView *webView;

-(IBAction)home:(id)sender;
-(IBAction)urlEntered:(id)sender;
-(IBAction)jsTest:(id)sender;

@end
