/**
 * @file GiCanvasDummy.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-10-7
 */

import touchvg.jni.GiCanvas;
import touchvg.jni.GiBitmap;

public class GiCanvasDummy extends GiCanvas {

    public GiCanvasDummy() {
        System.err.println(this + ".GiCanvasDummy()");
    }

    @Override
    protected void finalize() {
        System.err.println(this + ".finalize()");
        super.finalize();
    }

    @Override
    public synchronized void delete() {
        System.err.println(this + ".delete()");
        super.delete();
    }

    @Override
    protected void swigDirectorDisconnect() {
        System.err.println(this + ".swigDirectorDisconnect()");
        super.swigDirectorDisconnect();
    }

    @Override
    public void swigReleaseOwnership() {
        System.err.println(this + ".swigReleaseOwnership()");
        super.swigReleaseOwnership();
    }

    @Override
    public void swigTakeOwnership() {
        System.err.println(this + ".swigTakeOwnership()");
        super.swigTakeOwnership();
    }

    @Override
    public void setPen(int argb, float width, int style) {
        System.err.println(this + ".setPen(" + argb + ", " + width + ", " + style + ")");
    }

    @Override
    public void setBrush(int argb, int style) {
        System.err.println(this + ".setBrush(" + argb + ", " + style + ")");
    }

    @Override
    public void setAntialias(boolean antiAlias) {
        System.err.println(this + ".setAntialias(" + antiAlias + ")");
    }

    @Override
    public void saveClip() {
        System.err.println(this + ".saveClip()");
    }

    @Override
    public void restoreClip() {
        System.err.println(this + ".restoreClip()");
    }

    @Override
    public void clearRect(float x, float y, float w, float h) {
        System.err.println(this + ".clearRect("
            + x + ", " + y + ", " + w + ", " + h + ")");
    }

    @Override
    public void drawRect(float x, float y, float w, float h, boolean stroke, boolean fill) {
        System.err.println(this + ".drawRect("
            + x + ", " + y + ", " + w + ", " + h + ", " + stroke + ", " + fill + ")");
    }

    @Override
    public void clipRect(float x, float y, float w, float h) {
        System.err.println(this + ".clipRect("
            + x + ", " + y + ", " + w + ", " + h + ")");
    }

    @Override
    public void drawLine(float x1, float y1, float x2, float y2) {
        System.err.println(this + ".drawLine("
            + x1 + ", " + y1 + ", " + x2 + ", " + y2 + ")");
    }

    @Override
    public void drawEllipse(float x, float y, float w, float h, boolean stroke, boolean fill) {
        System.err.println(this + ".drawEllipse("
            + x + ", " + y + ", " + w + ", " + h + ", " + stroke + ", " + fill + ")");
    }

    @Override
    public void beginPath() {
        System.err.println(this + ".beginPath()");
    }

    @Override
    public void moveTo(float x, float y) {
        System.err.println(this + ".moveTo(" + x + ", " + y + ")");
    }

    @Override
    public void lineTo(float x, float y) {
        System.err.println(this + ".lineTo(" + x + ", " + y + ")");
    }

    @Override
    public void bezierTo(float c1x, float c1y, float c2x, float c2y, float x, float y) {
        System.err.println(this + ".bezierTo("
            + c1x + ", " + c1y + ", " + c2x + ", " + c2y + ", " + x + ", " + y + ")");
    }

    @Override
    public void quadTo(float cpx, float cpy, float x, float y) {
        System.err.println(this + ".quadTo("
            + cpx + ", " + cpy + ", " + x + ", " + y + ")");
    }

    @Override
    public void closePath() {
        System.err.println(this + ".closePath()");
    }

    @Override
    public void drawPath(boolean stroke, boolean fill) {
        System.err.println(this + ".drawPath(" + stroke + ", " + fill + ")");
    }

    @Override
    public void clipPath() {
        System.err.println(this + ".clipPath()");
    }

    @Override
    public void drawHandle(float x, float y, int type) {
        System.err.println(this + ".clipPath()");
    }

    @Override
    public void drawBitmap(GiBitmap bitmap, float x, float y,
                           float scale, float angle) {
        System.err.println(this + ".clipPath()");
    }

}
