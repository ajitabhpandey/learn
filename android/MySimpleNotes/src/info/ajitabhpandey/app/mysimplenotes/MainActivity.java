package info.ajitabhpandey.app.mysimplenotes;

import java.util.List;

import info.ajitabhpandey.app.mysimplenotes.data.NoteDataItem;
import info.ajitabhpandey.app.mysimplenotes.data.NoteDataSource;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;


public class MainActivity extends Activity {
	
	private NoteDataSource datasource;
	

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        datasource = new NoteDataSource(this);
        List<NoteDataItem> notes = datasource.findAll();
        NoteDataItem note = notes.get(0);
        note.setDataItemValue("Updated");
        
        datasource.updateNote(note);
        
        notes.get(0);
        
        Log.i("NOTES", note.getDataItemKey() + ": " + note.getDataItemValue());

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
