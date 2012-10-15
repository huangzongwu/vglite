/**
 * @file ViewFactory.mm
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-19
 */
#import "GraphView01.h"

static UIView* addView(NSMutableArray *arr, NSString* title, UIView* view)
{
    UIViewController *controller = [[UIViewController alloc] init];
    controller.title = title;
    if (view) {
        controller.view = view;
    }
    [arr addObject:controller];
    [controller release];
    
    return controller.view;
}

void getViewControllers(NSMutableArray *arr)
{
    GraphView01 *view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x01;
    addView(arr, @"testRect", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x02;
    addView(arr, @"testLine", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x04;
    addView(arr, @"testDot", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x08;
    addView(arr, @"testEllipse", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x10;
    addView(arr, @"testQuadBezier", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x20;
    addView(arr, @"testCubicBezier", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x40;
    addView(arr, @"testPolygon", view1);
    
    view1 = [[GraphView01 alloc]initWithFrame:CGRectNull];
    view1.tests = 0x100;
    addView(arr, @"testClipPath", view1);
}
