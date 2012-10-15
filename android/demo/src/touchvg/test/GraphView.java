/**
 * @file GraphView.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.test;

import touchvg.canvas.GiCanvasEx;
import android.graphics.Canvas;
import touchvg.jni.TestCanvas;

public class GraphView extends TestView {
	protected GiCanvasEx mCanvas = new GiCanvasEx();
	
	public GraphView() {
		TestCanvas.initRand();
	}
	
	@Override
	protected void onDraw(Canvas canvas) {
		if (mCanvas.beginPaint(canvas)) {
			onDraw(mCanvas);
			mCanvas.endPaint();
		}
	}
	
	protected void onDraw(GiCanvasEx canvas) {
	}
}
