/**
 * @file GiCanvasEx.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.canvas;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.DashPathEffect;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PathEffect;
import android.graphics.RectF;
import touchvg.jni.GiCanvas;

public class GiCanvasEx extends GiCanvas {
    private Path mPath = null;
    private Paint mPen = new Paint();
    private Paint mBrush = new Paint();
    private Canvas mCanvas = null;
    private int mBkColor = 0;
    private PathEffect mEffects = null;
    private static final float patDash[]      = { 5, 5 };
    private static final float patDot[]       = { 1, 2 };
    private static final float patDashDot[]   = { 10, 2, 2, 2 };
    private static final float dashDotdot[]   = { 20, 2, 2, 2, 2, 2 };
    private Bitmap[] mBitmaps;
    
    static {
        System.loadLibrary("touchvg");
    }
    
    public GiCanvasEx() {
    }
    
    @Override
    public synchronized void delete() {     // Override for debug it.
        if (getCPtr(this) != 0)
            super.delete();
    }
    
    public void setBackgroundColor(int color) {
        mBkColor = color;
    }
    
    public Canvas getCanvas() {
        return mCanvas;
    }
    
    public boolean beginPaint(Canvas canvas) {
        if (this.mCanvas != null || canvas == null) {
            return false;
        }
        
        this.mCanvas = canvas;
        
        mPen.setAntiAlias(true);                        // 反走样
        mPen.setDither(true);                           // 高精度颜色采样，会略慢
        mPen.setStyle(Paint.Style.STROKE);              // 仅描边
        mPen.setPathEffect(null);                       // 实线
        mPen.setStrokeCap(Paint.Cap.ROUND);             // 圆端
        mPen.setStrokeJoin(Paint.Join.ROUND);           // 折线转角圆弧过渡
        mBrush.setStyle(Paint.Style.FILL);              // 仅填充
        mBrush.setColor(0);                             // 默认透明，不填充
        
        return true;
    }
    
    public void endPaint() {
        this.mCanvas = null;
    }
    
    private void makeLinePattern(float arr[], float width)
    {
        float phase = 0;
        float f[] = new float[arr.length];
        for (int i = 0; i < arr.length; i++) {
            f[i] = arr[i] * (width < 1 ? 1 : width);
        }
        this.mEffects = new DashPathEffect(f, phase);
    }
    
    @Override
    public void setPen(int argb, float width, int style) {
        mPen.setColor(argb);
        if (width > 0) {
            mPen.setStrokeWidth(width);
            mPen.setAlpha(width < 0.9f ? mPen.getAlpha() / 2 : mPen.getAlpha());
        }
        
        if (style >= 0 && style <= 4) {
            if (style == 1)
                this.makeLinePattern(patDash, width);
            else if (style == 2)
                this.makeLinePattern(patDot, width);
            else if (style == 3)
                this.makeLinePattern(patDashDot, width);
            else if (style == 4)
                this.makeLinePattern(dashDotdot, width);
            else
                this.mEffects = null;
            mPen.setPathEffect(this.mEffects);
            mPen.setStrokeCap(this.mEffects != null ? Paint.Cap.BUTT : Paint.Cap.ROUND);
        }
    }
    
    @Override
    public void setBrush(int argb, int style) {
        if (style == 0)
            mBrush.setColor(argb);
    }
    
    @Override
    public void setAntialias(boolean antiAlias) {
        mPen.setAntiAlias(antiAlias);
    }
    
    @Override
    public void saveClip() {
        mCanvas.save(Canvas.CLIP_SAVE_FLAG);
    }
    
    @Override
    public void restoreClip() {
        mCanvas.restore();
    }
    
    @Override
    public void clearRect(float x, float y, float w, float h) {
        if ((int)(w + 0.5f) == mCanvas.getWidth() && (int)(h + 0.5f) == mCanvas.getHeight()) {
            mCanvas.drawColor(mBkColor);
        }
        else {
            Paint paint = new Paint();
            paint.setColor(mBkColor);
            paint.setStyle(Paint.Style.FILL);
            mCanvas.drawRect(x, y, x + w, y + h, paint);
        }
    }
    
    @Override
    public void drawRect(float x, float y, float w, float h, boolean stroke, boolean fill) {
        if (fill)
            mCanvas.drawRect(x, y, x + w, y + h, mBrush);
        if (stroke)
            mCanvas.drawRect(x, y, x + w, y + h, mPen);
    }
    
    @Override
    public void clipRect(float x, float y, float w, float h) {
        mCanvas.clipRect(x, y, x + w, y + h);
    }
    
    @Override
    public void drawLine(float x1, float y1, float x2, float y2) {
        mCanvas.drawLine(x1, y1, x2, y2, mPen);
    }
    
    @Override
    public void drawEllipse(float x, float y, float w, float h, boolean stroke, boolean fill) {
        if (fill)
            mCanvas.drawOval(new RectF(x, y, x + w, y + h), mBrush);
        if (stroke)
            mCanvas.drawOval(new RectF(x, y, x + w, y + h), mPen);
    }
    
    @Override
    public void beginPath() {
        if (mPath == null)
            mPath = new Path();
        else
            mPath.reset();
    }
    
    @Override
    public void moveTo(float x, float y) {
        mPath.moveTo(x, y);
    }
    
    @Override
    public void lineTo(float x, float y) {
        mPath.lineTo(x, y);
    }
    
    @Override
    public void bezierTo(float c1x, float c1y, float c2x, float c2y, float x, float y) {
        mPath.cubicTo(c1x, c1y, c2x, c2y, x, y);
    }
    
    @Override
    public void quadTo(float cpx, float cpy, float x, float y) {
        mPath.quadTo(cpx, cpy, x, y);
    }
    
    @Override
    public void closePath() {
        mPath.close();
    }
    
    @Override
    public void drawPath(boolean stroke, boolean fill) {
        if (fill)
            mCanvas.drawPath(mPath, mBrush);
        if (stroke)
            mCanvas.drawPath(mPath, mPen);
    }
    
    @Override
    public void clipPath() {
        mCanvas.clipPath(mPath);
    }
    
    public void setBitmaps(Bitmap[] bmps) {
    	mBitmaps = bmps;
    }
    
    public Bitmap getHandleBitmap(int type) {
    	return type < mBitmaps.length ? mBitmaps[type] : null;
    }
    
    @Override
    public void drawHandle(float x, float y, int type) {
        Bitmap bmp = getHandleBitmap(type);
        if (bmp != null) {
            mCanvas.drawBitmap(bmp, x - bmp.getWidth() / 2, y - bmp.getHeight() / 2, null);
        }
    }
    
    @Override
    public void drawBitmap(String name, float xc, float yc,
                           float w, float h, float angle) {
    	Bitmap bmp = getHandleBitmap(3);
    	if (bmp != null && bmp.getWidth() > 0) {
    		Matrix mat = new Matrix();
    		mat.postRotate(angle);
    		mat.postScale(w / bmp.getWidth(), h / bmp.getHeight());
    		mat.postTranslate(xc, yc);
    		mCanvas.drawBitmap(bmp, mat, null);
    	}
    }
    
    @Override
    public void drawTextAt(String text, float x, float y, float h, int align) {
    }
}
