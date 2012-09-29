/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.test;

import android.content.Context;
import android.view.View;

public class TestView extends View {
	private static Context newContext;
	protected int mCreateFlags;
	
	public static TestView createView(Context context, String className, int createFlags) {
		TestView view = null;
		newContext = context;
		try {
			view = (TestView)Class.forName(className).newInstance();
			view.mCreateFlags = createFlags;
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
		newContext = null;
		return view;
	}
	
	protected TestView() {
		super(newContext);
	}
	
	protected boolean hasFlag(int mask) {
		return (mCreateFlags & mask) != 0;
	}
}
