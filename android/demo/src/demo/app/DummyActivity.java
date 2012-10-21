/**
 * @file DummyActivity.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package demo.app;

import demo.view.TestView;
import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;

public class DummyActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        int color = Color.LTGRAY;
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setBackgroundColor(color);	// 绘图视图是透明的
        this.setContentView(layout);
        
        Bundle bundle = this.getIntent().getExtras();
        TestView view = TestView.createView(this, bundle.getString("className"), bundle.getInt("flags"));
        
        if (view != null) {
        	layout.addView(view, new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT));
        	view.setBackgroundColor(color);				// 将只应用在画布上，视图重载后仍然是透明色
        	this.setTitle(bundle.getString("title"));
        }
    }
    
    @Override
    public void onDestroy() {
    	super.onDestroy();
    }
}
