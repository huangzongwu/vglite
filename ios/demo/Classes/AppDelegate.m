/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-19
 */
#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@interface AppDelegate () {
    UIWindow *_window;
    UINavigationController *_navigationController;
    UISplitViewController *_splitViewController;
}
@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_splitViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        MasterViewController *controller = [[MasterViewController alloc] init];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller release];
        _window.rootViewController = _navigationController;
    }
    else {
        MasterViewController *controller = [[MasterViewController alloc] init];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller release];
        
        DetailViewController *detailController = [[DetailViewController alloc] init];
        UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailController];
        [detailController release];
    	
    	controller.detailViewController = detailController;
    	
        _splitViewController = [[UISplitViewController alloc] init];
        _splitViewController.delegate = detailController;
        _splitViewController.viewControllers = [NSArray arrayWithObjects:_navigationController, detailNavigationController, nil];
        
        _window.rootViewController = _splitViewController;
        [detailNavigationController release];
    }
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

@end
