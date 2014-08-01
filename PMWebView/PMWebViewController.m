//
//  PMWebViewController.m
//  PMWebView
//
//  Created by Paola Mata Maldonado on 7/21/14.
//
//

#import "PMWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface PMWebViewController ()

@end

@implementation PMWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
    urlTextField.delegate = self;
//    [self home:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"JSSample" ofType:@"html" inDirectory:@""] isDirectory:NO]]];
}


-(IBAction)home:(id)sender{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com" ]]];
}

-(IBAction)urlEntered:(id)sender{
    NSString *query = urlTextField.text;
    NSURL *urlquery = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",query]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlquery];
    [self.webView loadRequest:urlRequest];

}

-(IBAction)jsTest:(id)sender{
   [self.webView stringByEvaluatingJavaScriptFromString: @"alert('Objective-C button pressed received in JavaScript!');"];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *currentURL = self.webView.request.URL.absoluteString;
    urlTextField.text = currentURL;
    
    JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];    context[@"testFunction"] = ^(NSString *message) {
        [self logJSFunction:message];
    };
}

-(void)logJSFunction:(NSString*)message{
    NSLog(@"%@",message);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"JavaScript button press received in Objective C" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error: %@", [error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
 
    [textField selectAll:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
