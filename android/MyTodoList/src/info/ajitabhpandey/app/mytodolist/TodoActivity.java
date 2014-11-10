package info.ajitabhpandey.app.mytodolist;

import info.ajitabhpandey.app.mytodolist.R;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import org.apache.commons.io.FileUtils;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemLongClickListener;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;

public class TodoActivity extends Activity {
	
	ArrayList<String> items;
	ArrayAdapter<String> itemsAdapter;
	ListView lvItems;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_todo);
        
        lvItems = (ListView) findViewById(R.id.lvItems);
        items = new ArrayList<String>();
        itemsAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, items);
        
        // Loading the items on create
        readItems();
        itemsAdapter = new ArrayAdapter<String>(getBaseContext(), android.R.layout.simple_list_item_1, items);
        lvItems.setAdapter(itemsAdapter);
        
        setupListViewListener();
    }
    
    public void addTodoItem(View v) {
    	EditText etNewItem = (EditText) findViewById(R.id.etNewItem);
    	itemsAdapter.add(etNewItem.getText().toString());
    	etNewItem.setText("");
    	// Save Items when a new list item is added
    	saveItems();
    }
    
    public void setupListViewListener() {
    	lvItems.setOnItemLongClickListener(new OnItemLongClickListener() {
    		@Override
    		public boolean onItemLongClick(AdapterView<?> parent, 
    				View view, int position, long rowId) {
    			items.remove(position);
    			itemsAdapter.notifyDataSetChanged();
    			// Save Items when a list item is removed
    			saveItems();
    			return true;
    		}
		});
    }
    
    // Loading items from a file
    private void readItems() {
    	File filesDir = getFilesDir();
    	File todoFile = new File(filesDir, "todo.txt");
    	try {
    		items = new ArrayList<String>(FileUtils.readLines(todoFile));
    	} catch (IOException e) {
    		items = new ArrayList<String>();
    		e.printStackTrace();
    	}
    }
    
    // Saving items to file
    private void saveItems() {
    	File filesDir = getFilesDir();
    	File todoFile = new File(filesDir, "todo.txt");
    	try {
    		FileUtils.writeLines(todoFile, items);
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
    }
}
