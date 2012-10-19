/**
 * @file GraphView.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.test;

import touchvg.canvas.GiCanvasEx;
import android.app.Activity;
import android.content.Context;
import android.graphics.Canvas;
import touchvg.jni.TestCanvas;

public class GraphView extends TestView {
	protected GiCanvasEx mCanvas = new GiCanvasEx();
	
	public GraphView() {
		TestCanvas.initRand();
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
		long ms = System.currentTimeMillis();
		if (mCanvas.beginPaint(canvas)) {
			onDraw(mCanvas);
			mCanvas.endPaint();
		}
		ms = System.currentTimeMillis() - ms;
		
		Activity activity = (Activity)this.getContext();
		String title = activity.getTitle().toString();
		int pos = title.lastIndexOf(' ');
		if (pos >= 0)
			title = title.substring(0, pos);
		activity.setTitle(title + " - " + Long.toString(ms) + " ms");
	}
	
	protected void onDraw(GiCanvasEx canvas) {
	}
}
