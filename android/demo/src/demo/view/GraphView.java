/**
 * @file GraphView.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package demo.view;

import touchvg.canvas.GiCanvasEx;
import demo.app.R.drawable;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import touchvg.jni.TestCanvas;

public class GraphView extends TestView {
	protected GiCanvasEx mCanvas = new GiCanvasEx();
	
	public GraphView() {
	}
	
	protected GraphView(Context context) {
		super(context);
	}
	
	@Override
	public void setBackgroundColor(int color) {
		mCanvas.setBackgroundColor(color);		// 视图仍然是透明色
    }
	
	@Override
	protected void onDraw(Canvas canvas) {
		if (mCanvas.getHandleBitmap(0) == null) {
			Bitmap bmp1 = ((BitmapDrawable)this.getResources().getDrawable(drawable.vgdot1)).getBitmap();
			Bitmap bmp2 = ((BitmapDrawable)this.getResources().getDrawable(drawable.vgdot2)).getBitmap();
			Bitmap bmp3 = ((BitmapDrawable)this.getResources().getDrawable(drawable.ic_launcher)).getBitmap();
			mCanvas.setBitmaps(new Bitmap[] { bmp1, bmp2, bmp3, bmp3 });
		}
		
		TestCanvas.initRand();
		long ms = System.currentTimeMillis();
		
		if (mCanvas.beginPaint(canvas)) {
			onDraw(mCanvas);
			mCanvas.endPaint();
		}
		ms = System.currentTimeMillis() - ms;
		
		Activity activity = (Activity)this.getContext();
		String title = activity.getTitle().toString();
		int pos = title.indexOf(' ');
		if (pos >= 0)
			title = title.substring(0, pos);
		activity.setTitle(title + " - " + Long.toString(ms) + " ms");
	}
	
	protected void onDraw(GiCanvasEx canvas) {
	}
	
	@Override
	protected void onDetachedFromWindow() {
		if (mCanvas != null) {
			mCanvas.delete();
			mCanvas = null;
		}
		super.onDetachedFromWindow();
	}
}
