/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.demo;

import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.app.ListActivity;
import android.content.Intent;

public class MainActivity extends ListActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        setListAdapter(new ArrayAdapter<DummyContent.DummyItem>(this,
        		android.R.layout.simple_list_item_1,
        		android.R.id.text1,
                DummyContent.ITEMS));
    }
    
    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
    	super.onListItemClick(l, v, position, id);

        Intent i = new Intent(this, DummyActivity.class);
        i.putExtra("className", DummyContent.ITEMS.get(position).id);
        i.putExtra("title", DummyContent.ITEMS.get(position).title);
        i.putExtra("flags", DummyContent.ITEMS.get(position).flags);
        startActivity(i);
    }
}
