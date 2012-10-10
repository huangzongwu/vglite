/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.demo;

import touchvg.test.TestView;
import android.app.Activity;
import android.os.Bundle;

public class DummyActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        Bundle bundle = this.getIntent().getExtras();
        TestView view = TestView.createView(this, bundle.getString("className"), bundle.getInt("flags"));
        
        if (view != null) {
        	this.setContentView(view);
        	this.setTitle(bundle.getString("title"));
        }
    }
    
    @Override
    public void onDestroy() {
    	super.onDestroy();
    }
}
