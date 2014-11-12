package info.ajitabhpandey.app.mysimplenotes;

import info.ajitabhpandey.app.mysimplenotes.data.NoteDataItem;
import info.ajitabhpandey.app.mysimplenotes.data.NoteDataSource;

import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ContextMenu.ContextMenuInfo;
import android.widget.AdapterView;
import android.widget.AdapterView.AdapterContextMenuInfo;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class MainActivity extends Activity {
	
	private static final int EDITOR_ACTIVITY_REQUEST = 1001;
	private static final int MENU_DELETE_ID = 1002;
	private int currentNoteId;
	private NoteDataSource datasource;
	List<NoteDataItem> noteList;
	ListView lvNotesList;
	

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        registerForContextMenu((ListView) findViewById(R.id.lvNotesList));
        
        datasource = new NoteDataSource(this);
	    
        refreshDisplay();

        // Sets up the Listener for the clicks on list items
        setupListViewListener();
    }

	private void refreshDisplay() {
    	lvNotesList = (ListView) findViewById(R.id.lvNotesList);
    	
		noteList = datasource.findAll();
		ArrayAdapter<NoteDataItem> adapter = 
				new ArrayAdapter<NoteDataItem>(this, R.layout.note_list_view_layout, 
						noteList);
		lvNotesList.setAdapter(adapter);
		
	}
	
    private void setupListViewListener() {
		lvNotesList.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				
				NoteDataItem note = noteList.get(position);
				
				Intent intent = new Intent(getApplicationContext(), 
						NoteItemEditorActivity.class);

				intent.putExtra("key", note.getDataItemKey());
				intent.putExtra("text", note.getDataItemValue());
				
				// Starts the editor activity
				startActivityForResult(intent, EDITOR_ACTIVITY_REQUEST);
				
			}
		});
		
	}

	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_create) {
            createNote();
        }
        return super.onOptionsItemSelected(item);
    }

	private void createNote() {
		
		NoteDataItem note = NoteDataItem.getNew();
		Intent intent = new Intent(this, NoteItemEditorActivity.class);
		intent.putExtra("key", note.getDataItemKey());
		intent.putExtra("text", note.getDataItemValue());
		startActivityForResult(intent, EDITOR_ACTIVITY_REQUEST);
		
	}
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == EDITOR_ACTIVITY_REQUEST && resultCode == RESULT_OK) {
			NoteDataItem note = new NoteDataItem();
			note.setDataItemKey(data.getStringExtra("key"));
			note.setDataItemValue(data.getStringExtra("text"));
			
			datasource.updateNote(note);
			refreshDisplay();
			
		}
	}
	
	@Override
	public void onCreateContextMenu(ContextMenu menu, View v,
			ContextMenuInfo menuInfo) {
		
		AdapterContextMenuInfo info = (AdapterContextMenuInfo) menuInfo;
		currentNoteId = (int) info.id;
		menu.add(0, MENU_DELETE_ID, 0, "Delete");
	}
	
	@Override
	public boolean onContextItemSelected(MenuItem item) {
		
		if (item.getItemId() == MENU_DELETE_ID) {
			NoteDataItem note = noteList.get(currentNoteId);
			datasource.removeNote(note);
			refreshDisplay();
		}
		return super.onContextItemSelected(item);
	}
}
