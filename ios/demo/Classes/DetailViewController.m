/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-19
 */
#import "DetailViewController.h"

@interface DetailViewController ()
@property (nonatomic, assign) UIPopoverController *masterPopoverController;
@end

@implementation DetailViewController

@synthesize masterPopoverController = _masterPopoverController;
@synthesize content = _content;

- (void)dealloc
{
    [_content release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Detail";
    }
    return self;
}

- (void)setContent:(UIViewController *)c
{
    if (_content) {
        [_content.view removeFromSuperview];
        [_content release];
    }
    _content = c;
    if (_content) {
        [_content retain];
        _content.view.frame = self.view.bounds;
        [self.view addSubview:_content.view];
        _content.view.autoresizingMask = 0xFF;
        [_content.view setNeedsDisplay];
    }
    self.title = _content ? _content.title : @"Detail";
}

- (void)clearCachedData
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Demos";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
