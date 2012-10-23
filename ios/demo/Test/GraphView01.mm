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
        self.backgroundColor = [UIColor clearColor];
        //self.opaque = NO;
        //self.clearsContextBeforeDrawing = YES;
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

// 下面代码源自 周宏伟 2011-05-31 的博客
// http://www.cnblogs.com/zhw511006/archive/2011/05/31/2064049.html

#include <QuartzCore/CALayer.h>

@implementation CALayerTest

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    // 设置默认层要带圆角
    self.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.layer.cornerRadius = 50.f;
    self.layer.frame = CGRectInset(self.layer.frame, 10, 10);   // 在initWithFrame中则会冲掉
    
    // 添加一个带阴影效果的子层
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.shadowRadius = 5.f;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8f;
    sublayer.frame = CGRectMake(30, 30, 128, 128);
    [self.layer addSublayer:sublayer];
    
    // 为子层增加内容（图片），设置层的边框
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth = 2.f;
    sublayer.cornerRadius = 35.f;
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = sublayer.bounds;
    imageLayer.cornerRadius = 35.f;
    imageLayer.contents = (id)[UIImage imageNamed:@"app72.png"].CGImage;
    imageLayer.masksToBounds = YES;
    [sublayer addSublayer:imageLayer];
    
    // 自绘图层的演示: 设置所绘制层的delegate，实现drawLayer:inContext方法
    CALayer *customLayer = [CALayer layer];
    customLayer.backgroundColor = [UIColor greenColor].CGColor;
    customLayer.frame = CGRectMake(230, 30, 200, 300);
    [sublayer addSublayer:customLayer];
    customLayer.delegate = self;
    [customLayer setNeedsDisplay];   // 通知层需要进行绘制
}

// 实现了drawRect则会调用drawLayer，默认是黑色背景
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//}

static inline double radians (double degrees) { return degrees * M_PI/180; }

// 填充带阴影的圆点
void MyDrawColoredPattern (void*info, CGContextRef context) {
    
    CGColorRef dotColor =[UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor =[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians(360), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, radians(360), 0);
    CGContextFillPath(context);
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    // 填充蓝色背景
    CGColorRef bgColor =[UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    static const CGPatternCallbacks callbacks ={0, &MyDrawColoredPattern, NULL};
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);  // 没有填充色
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           layer.bounds,
                                           CGAffineTransformIdentity,
                                           24,
                                           24,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);
}

@end

#include <CoreText/CoreText.h>

@implementation DrawTextTest

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // http://blog.chinaunix.net/uid-25458681-id-3381925.html
    //
    
    rect = CGContextGetClipBoundingBox(ctx);
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(ctx, rect);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeRect(ctx, CGRectMake(100, 100, 400, 200));
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5] CGColor]);
    
    NSString *str = @"fucking汉1";
    [str drawAtPoint:CGPointMake(100, 100) withFont:[UIFont systemFontOfSize:64.0]];
    //CGAffineTransform f = CGContextGetTextMatrix(ctx);
    
    UIFont *_font = [UIFont systemFontOfSize:64.0];
    CGContextSelectFont(ctx, [_font.fontName UTF8String], _font.pointSize, kCGEncodingMacRoman);
    
    CGContextSetTextMatrix(ctx, CGAffineTransformScale(CGAffineTransformIdentity, 1, -1));
    CGContextSetTextDrawingMode(ctx, kCGTextStroke);
    CGContextShowTextAtPoint(ctx, 100.0, 100.0, [str UTF8String], str.length);
    
    // http://www.cnblogs.com/itentic/archive/2012/06/17/2552311.html
    // 如果编码超出MacRoman的范围，要使用CGContextShowGlyphsAtPoint来绘制，在CoreText框架获取字符图元
    
    UniChar *characters;
    CGGlyph *glyphs;
    CFIndex count;
    
    CTFontRef ctFont = CTFontCreateWithName(CFSTR("STHeitiSC-Light"), 64, NULL);
    CTFontDescriptorRef ctFontDesRef = CTFontCopyFontDescriptor(ctFont);
    CGFontRef cgFont = CTFontCopyGraphicsFont(ctFont, &ctFontDesRef); 
    CGContextSetFont(ctx, cgFont);
    CFNumberRef pointSizeRef = (CFNumberRef)CTFontDescriptorCopyAttribute(ctFontDesRef,kCTFontSizeAttribute);
    CGFloat fontSize;
    CFNumberGetValue(pointSizeRef, kCFNumberCGFloatType,&fontSize);
    CGContextSetFontSize(ctx, fontSize);
    count = CFStringGetLength((CFStringRef)str);
    characters = (UniChar *)malloc(sizeof(UniChar) * count);
    glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * count);
    CFStringGetCharacters((CFStringRef)str, CFRangeMake(0, count), characters);
    CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, count);
    CGContextShowGlyphsAtPoint(ctx, 100, 300, glyphs, str.length);
    
    free(characters);
    free(glyphs);
}

@end
