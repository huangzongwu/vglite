/**
 * @file GraphView01.mm
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-20
 */
#import "GraphView01.h"
#include "GiQuartzCanvas.h"
#include <testcanvas.h>

@implementation GraphViewBase

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw; // 不缓存图像，每次重画
        self.opaque = NO;
        self.clearsContextBeforeDrawing = YES;
        
        TestCanvas::initRand();
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    GiQuartzCanvas canvas;
    
    if (canvas.beginPaint(UIGraphicsGetCurrentContext())) {
        [self drawInCanvas:&canvas];
        canvas.endPaint();
    }
}

- (void)drawInCanvas:(GiCanvas*)canvas {}

@end

@implementation GraphView01
@synthesize tests;

- (void)drawInCanvas:(GiCanvas*)canvas
{
    if (tests & 0x01)
        TestCanvas::testRect(canvas);
    if (tests & 0x02)
        TestCanvas::testLine(canvas);
    if (tests & 0x04)
        TestCanvas::testDot(canvas);
    if (tests & 0x08)
        TestCanvas::testEllipse(canvas);
    if (tests & 0x10)
        TestCanvas::testQuadBezier(canvas);
    if (tests & 0x20)
        TestCanvas::testCubicBezier(canvas);
    if (tests & 0x40)
        TestCanvas::testPolygon(canvas);
    if (tests & 0x100)
        TestCanvas::testClipPath(canvas);
}

@end
