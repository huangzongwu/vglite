/**
 * @file GraphView01.h
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-20
 */
#import <UIKit/UIKit.h>

struct GiCanvas;

@interface GraphViewBase : UIView

- (void)drawInCanvas:(GiCanvas*)canvas;
- (void)saveAsPdf;
- (void)saveAsPng;

@end

@interface GraphView01 : GraphViewBase

@property (nonatomic, assign) int tests;

@end
