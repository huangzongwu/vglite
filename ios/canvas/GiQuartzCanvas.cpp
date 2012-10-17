/**
 * @file GiQuartzCanvas.cpp
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-21
 */
#include "GiQuartzCanvas.h"

GiQuartzCanvas::GiQuartzCanvas() : _ctx(NULL)
{
}

GiQuartzCanvas::~GiQuartzCanvas()
{
}

bool GiQuartzCanvas::beginPaint(CGContextRef context)
{
    if (_ctx || !context)
        return false;
    
    _ctx = context;
    
    CGContextSetShouldAntialias(_ctx, true);        // 两者都为true才反走样
    CGContextSetAllowsAntialiasing(_ctx, true);
    
    CGContextSetLineCap(_ctx, kCGLineCapRound);     // 圆端
    CGContextSetLineJoin(_ctx, kCGLineJoinRound);   // 折线转角圆弧过渡

    CGContextSetRGBFillColor(_ctx, 0, 0, 0, 0);     // 默认不填充
    
    return true;
}

void GiQuartzCanvas::endPaint()
{
    _ctx = NULL;
}

static inline float colorPart(int argb, int bit)
{
    return (float)((argb >> bit) & 0xFF) / 255.f;
}

void GiQuartzCanvas::penChanged(int argb, float width, int style)
{
    const CGFloat patDash[]      = { 5, 5, 0 };
    const CGFloat patDot[]       = { 1, 2, 0 };
    const CGFloat patDashDot[]   = { 10, 2, 2, 2, 0 };
    const CGFloat dashDotdot[]   = { 20, 2, 2, 2, 2, 2, 0 };
    const CGFloat* const lpats[] = { NULL, patDash, patDot, patDashDot, dashDotdot };
    
    CGContextSetRGBStrokeColor(_ctx, colorPart(argb, 16), colorPart(argb, 8),
                               colorPart(argb, 0), colorPart(argb, 24));
    if (width > 0)
        CGContextSetLineWidth(_ctx, width);
    
    if (style > 0 && style < sizeof(lpats)/sizeof(lpats[0])) {
        CGFloat pattern[6];
        int n = 0;
        for (; lpats[style][n] > 0.1f; n++) {
            pattern[n] = lpats[style][n] * (width < 1.f ? 1.f : width);
        }
        CGContextSetLineDash(_ctx, 0, pattern, n);
        CGContextSetLineCap(_ctx, kCGLineCapButt);
    }
    else if (0 == style) {
        CGContextSetLineDash(_ctx, 0, NULL, 0);
        CGContextSetLineCap(_ctx, kCGLineCapRound);
    }
}

void GiQuartzCanvas::brushChanged(int argb, int style)
{
    if (0 == style) {
        CGContextSetRGBFillColor(_ctx, colorPart(argb, 16), colorPart(argb, 8),
                                 colorPart(argb, 0), colorPart(argb, 24));
    }
}

void GiQuartzCanvas::antiAliasChanged(bool antiAlias)
{
    CGContextSetAllowsAntialiasing(_ctx, antiAlias);
}

void GiQuartzCanvas::saveClip()
{
    CGContextBeginTransparencyLayer(_ctx, NULL);
}

void GiQuartzCanvas::restoreClip()
{
    CGContextEndTransparencyLayer(_ctx);
}

void GiQuartzCanvas::clearRect(float x, float y, float w, float h)
{
    CGContextClearRect(_ctx, CGRectMake(x, y, w, h));
}

void GiQuartzCanvas::drawRect(float x, float y, float w, float h, bool stroke, bool fill)
{
    if (fill) {
        CGContextFillRect(_ctx, CGRectMake(x, y, w, h));
    }
    if (stroke) {
        CGContextStrokeRect(_ctx, CGRectMake(x, y, w, h));
    }
}

void GiQuartzCanvas::clipRect(float x, float y, float w, float h)
{
    CGContextClipToRect(_ctx, CGRectMake(x, y, w, h));
}

void GiQuartzCanvas::drawLine(float x1, float y1, float x2, float y2)
{
    CGContextBeginPath(_ctx);
    CGContextMoveToPoint(_ctx, x1, y1);
    CGContextAddLineToPoint(_ctx, x2, y2);
    CGContextStrokePath(_ctx);
}

void GiQuartzCanvas::drawDot(float x, float y, float radius, int style)
{
    if (0 == style) {
        CGRect rect = CGRectMake(x - radius, y - radius, 2 * radius, 2 * radius);
        CGContextFillEllipseInRect(_ctx, rect);
        CGContextStrokeEllipseInRect(_ctx, rect);
    }
}

void GiQuartzCanvas::drawEllipse(float x, float y, float w, float h, bool stroke, bool fill)
{
    if (fill) {
        CGContextFillEllipseInRect(_ctx, CGRectMake(x, y, w, h));
    }
    if (stroke) {
        CGContextStrokeEllipseInRect(_ctx, CGRectMake(x, y, w, h));
    }
}

void GiQuartzCanvas::beginPath()
{
    CGContextBeginPath(_ctx);
}

void GiQuartzCanvas::moveTo(float x, float y)
{
    CGContextMoveToPoint(_ctx, x, y);
}

void GiQuartzCanvas::lineTo(float x, float y)
{
    CGContextAddLineToPoint(_ctx, x, y);
}

void GiQuartzCanvas::bezierTo(float c1x, float c1y, float c2x, float c2y, float x, float y)
{
    CGContextAddCurveToPoint(_ctx, c1x, c1y, c2x, c2y, x, y);
}

void GiQuartzCanvas::quadTo(float cpx, float cpy, float x, float y)
{
    CGContextAddQuadCurveToPoint(_ctx, cpx, cpy, x, y);
}

void GiQuartzCanvas::closePath()
{
    CGContextClosePath(_ctx);
}

void GiQuartzCanvas::drawPath(bool stroke, bool fill)
{
    CGContextDrawPath(_ctx, (stroke && fill) ? kCGPathFillStroke
                      : (fill ? kCGPathFill : kCGPathStroke));  // will clear the path
}

void GiQuartzCanvas::clipPath()
{
    CGContextClip(_ctx);
}
