﻿/**
 * @file gicanvas.h
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-20
 */
#ifndef TOUCHVG_GICANVAS_H
#define TOUCHVG_GICANVAS_H

/** 设备画布接口.
 * 在派生类中使用某一种图形库实现其绘图函数，坐标单位为点或像素.
 * 默认绘图属性为：黑色画笔、线宽=1、实线、反走样、不填充.
 * @ingroup GROUP_CANVAS
 */
class GiCanvas
{
public:
    virtual ~GiCanvas() {}
    
    /** 设置画笔属性.
     * @param argb 颜色值，包含alpha分量，按字节从高到低顺序依次是A、R、G、B分量值，例如 alpha = (argb>>24) & 0xFF.
     * @param width 线宽，单位为点，正数，如果为负数则忽略该参数.
     * @param style 线型，0-实线，1-虚线，2-点线，3-点划线，4-双点划线，5-空线，其余值为自定义线型，如果为负数则忽略该参数.
     */
    virtual void penChanged(int argb, float width, int style) = 0;
    
    /** 设置画刷填充属性.
     * @param argb 填充色，包含alpha分量，按字节从高到低顺序依次是A、R、G、B分量值，例如 alpha = (argb>>24) & 0xFF.
     * @param style 填充类型，0-实填充，其余正数值为自定义填充.
     */
    virtual void brushChanged(int argb, int style) = 0;
    
    /** 设置是否反走样绘制 */
    virtual void antiAliasChanged(bool antiAlias) = 0;

    
    /** 清除指定矩形区域的显示内容，透明显示，仅用于在视图和图像上的绘制 */
    virtual void clearRect(float x, float y, float w, float h) = 0;
    
    /** 显示矩形框，可描边和填充 */
    virtual void drawRect(float x, float y, float w, float h, bool stroke, bool fill) = 0;
    
    /** 给定起始坐标，显示一段直线 */
    virtual void drawLine(float x1, float y1, float x2, float y2) = 0;
    
    /** 在指定中心位置显示一个小圈.
     * @param x 中心位置X
     * @param y 中心位置Y
     * @param radius 半径，style为0时有效
     * @param style 小圈类型，0表示使用当前画笔和画刷显示一个圆，正数表示特定符号.
     */
    virtual void drawDot(float x, float y, float radius, int style) = 0;
    
    /** 在给定矩形框内显示一个椭圆，可描边和填充 */
    virtual void drawEllipse(float x, float y, float w, float h, bool stroke, bool fill) = 0;

    
    /** 开始新的路径，清除当前路径 */
    virtual void beginPath() = 0;
    
    /** 在当前路径中添加一个子路径，指定子路径的当前点、起始点 */
    virtual void moveTo(float x, float y) = 0;
    
    /** 添加一条从当前点到指定点的线段 */
    virtual void lineTo(float x, float y) = 0;
    
    /** 添加一条从当前点到指定点(x,y)的三次贝塞尔曲线段，中间控制点为(c1x,c1y)、(c2x,c2y) */
    virtual void bezierTo(float c1x, float c1y, float c2x, float c2y, float x, float y) = 0;
    
    /** 添加一条从当前点到指定点(x,y)的二次贝塞尔曲线段，中间控制点为(cpx,cpy) */
    virtual void quadTo(float cpx, float cpy, float x, float y) = 0;
    
    /** 闭合当前路径，添加一条从当前点到子路径起始点的线段 */
    virtual void closePath() = 0;
    
    /** 绘制并清除当前路径 */
    virtual void drawPath(bool stroke, bool fill) = 0;
    
    
    /** 保存剪裁区域. 在调用 clipRect() 或 clipPath() 前调用本函数，使用 restoreClip() 恢复剪裁区域. */
	virtual void saveClip() = 0;
	
	/** 恢复剪裁区域. 与 saveClip() 配套使用 */
	virtual void restoreClip() = 0;
	
    /** 设置剪裁区域为当前剪裁区域与给定矩形的交集.
	 * 给定矩形的宽高不一定为正数，所设置的剪裁区域影响后续绘图，可能会清除当前路径.
	 * @see saveClip, restoreClip
	 */
    virtual void clipRect(float x, float y, float w, float h) = 0;
	
    /** 设置剪裁区域为当前剪裁区域与当前路径的交集.
	 * 调用 beginPath() 等函数设置当前路径，由于 drawPath() 会清除当前路径，所以 clipPath() 要先于 drawPath() 调用.
	 * @see saveClip, restoreClip, beginPath
	 */
    virtual void clipPath() = 0;
};

#endif // TOUCHVG_GICANVAS_H
