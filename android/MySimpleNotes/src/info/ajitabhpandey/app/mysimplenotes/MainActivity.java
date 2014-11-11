package info.ajitabhpandey.app.mysimplenotes;

import java.util.List;

import info.ajitabhpandey.app.mysimplenotes.data.NoteDataItem;
import info.ajitabhpandey.app.mysimplenotes.data.NoteDataSource;
import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class MainActivity extends Activity {
	
	private NoteDataSource datasource;
	List<NoteDataItem> noteList;
	ListView lvNotesList;
	

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        datasource = new NoteDataSource(this);
        
        refreshDisplay();

    }

    private void refreshDisplay() {
    	lvNotesList = (ListView) findViewById(R.id.lvNotesList);
    	
		noteList = datasource.findAll();
		ArrayAdapter<NoteDataItem> adapter = 
				new ArrayAdapter<NoteDataItem>(this, R.layout.note_list_view_layout, noteList);
		lvNotesList.setAdapter(adapter);
		
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
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
