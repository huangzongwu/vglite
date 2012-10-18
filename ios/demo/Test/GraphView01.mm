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

- (void)didMoveToSuperview
{
    TestCanvas::initRand();
    [super didMoveToSuperview];
}

- (void)drawRect:(CGRect)rect
{
    GiQuartzCanvas canvas;
    NSDate *startTime = [NSDate date];
    
    if (canvas.beginPaint(UIGraphicsGetCurrentContext())) {
        [self drawInCanvas:&canvas];
        canvas.endPaint();
    }
    
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:startTime];
    
    UIViewController *detailc = (UIViewController *)self.superview.nextResponder;
    NSString *title = detailc.title;
    NSRange range = [title rangeOfString:@"-"];
    if (range.length > 0) {
        title = [title substringToIndex:range.location];
    }
    detailc.title = [title stringByAppendingFormat:@"-%dms", (int)(seconds * 1000)];
    NSLog(@"drawRect: %@", detailc.title);
}

- (void)drawInCanvas:(GiCanvas*)canvas {}

- (void)saveAsPdf
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                          NSUserDomainMask, YES) objectAtIndex:0];
    static int order = 0;
    NSString *filename = [NSString stringWithFormat:@"%@/page%d.pdf", path, ++order % 10];
    
    if (UIGraphicsBeginPDFContextToFile(filename, CGRectZero, nil)) {
        CGRect mediabox = self.bounds;
        UIGraphicsBeginPDFPageWithInfo(self.bounds, nil);
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetTextMatrix(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, mediabox.size.height));
        
        GiQuartzCanvas canvas;
        
        if (canvas.beginPaint(ctx)) {
            TestCanvas::initRand();
            [self drawInCanvas:&canvas];
            canvas.endPaint();
        }
        UIGraphicsEndPDFContext();
    }
}

- (void)saveAsPng
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height));
    
    GiQuartzCanvas canvas;
    
    if (canvas.beginPaint(ctx)) {
        TestCanvas::initRand();
        [self drawInCanvas:&canvas];
        canvas.endPaint();
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                          NSUserDomainMask, YES) objectAtIndex:0];
    static int order = 0;
    NSString *filename = [NSString stringWithFormat:@"%@/page%d.png", path, ++order % 10];
    
    NSData* imageData = UIImagePNGRepresentation(image);
    if (imageData) {
        [imageData writeToFile:filename atomically:NO];                 
    }
}

@end

@implementation GraphView01
@synthesize tests;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw; // 不缓存图像，每次重画
        self.opaque = NO;
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}

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
    if (tests & 0x80) {
        canvas->clearRect(100, 100, 400, 400);
    }
    if (tests & 0x100)
        TestCanvas::testClipPath(canvas);
}

@end
