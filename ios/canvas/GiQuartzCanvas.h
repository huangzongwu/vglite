/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-21
 */
#include <gicanvas.h>
#include <CoreGraphics/CGContext.h>

class GiQuartzCanvas : public GiCanvas
{
public:
    GiQuartzCanvas();
    virtual ~GiQuartzCanvas();
    
    bool beginPaint(CGContextRef context);
    void endPaint();
    
public:
    void penChanged(int argb, float width, int style);
    void brushChanged(int argb, int style);
    void antiAliasChanged(bool antiAlias);
    void saveClip();
    void restoreClip();
    void clearRect(float x, float y, float w, float h);
    void drawRect(float x, float y, float w, float h, bool stroke, bool fill);
    void clipRect(float x, float y, float w, float h);
    void drawLine(float x1, float y1, float x2, float y2);
    void drawDot(float x, float y, float radius, int style);
    void drawEllipse(float x, float y, float w, float h, bool stroke, bool fill);
    void beginPath();
    void moveTo(float x, float y);
    void lineTo(float x, float y);
    void bezierTo(float c1x, float c1y, float c2x, float c2y, float x, float y);
    void quadTo(float cpx, float cpy, float x, float y);
    void closePath();
    void drawPath(bool stroke, bool fill);
    void clipPath();
    
private:
    CGContextRef    _ctx;
};
