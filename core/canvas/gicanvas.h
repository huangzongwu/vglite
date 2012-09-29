/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-20
 */
#ifndef TOUCHVG_GICANVAS_H
#define TOUCHVG_GICANVAS_H

struct GiCanvas
{
    virtual ~GiCanvas() {}
    
    virtual void penChanged(int argb, float width, int style) = 0;
    virtual void brushChanged(int argb, int style) = 0;
    virtual void antiAliasChanged(bool antiAlias) = 0;
    
    virtual void beginTransparencyLayer() = 0;
    virtual void endTransparencyLayer() = 0;

    virtual void clearRect(float x, float y, float w, float h) = 0;
    virtual void drawRect(float x, float y, float w, float h, bool stroke, bool fill) = 0;
    virtual void clipRect(float x, float y, float w, float h) = 0;

    virtual void drawLine(float x1, float y1, float x2, float y2) = 0;
    virtual void drawDot(float x, float y, float radius, int style) = 0;
    virtual void drawEllipse(float x, float y, float w, float h, bool stroke, bool fill) = 0;

    virtual void beginPath() = 0;
    virtual void moveTo(float x, float y) = 0;
    virtual void lineTo(float x, float y) = 0;
    virtual void bezierTo(float c1x, float c1y, float c2x, float c2y, float x, float y) = 0;
    virtual void quadTo(float cpx, float cpy, float x, float y) = 0;
    virtual void closePath() = 0;
    virtual void drawPath(bool stroke, bool fill) = 0;
    virtual void clipPath() = 0;
};

#endif // TOUCHVG_GICANVAS_H
