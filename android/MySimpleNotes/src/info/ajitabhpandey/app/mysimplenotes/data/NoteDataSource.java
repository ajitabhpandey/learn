package info.ajitabhpandey.app.mysimplenotes.data;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import android.content.Context;
import android.content.SharedPreferences;

public class NoteDataSource {
	
	private static final String PREFKEY = "notes";
	private SharedPreferences notePrefs;
	
	public NoteDataSource(Context context) { 
		
		notePrefs = context.getSharedPreferences(PREFKEY, Context.MODE_PRIVATE);
	}

	public List<NoteDataItem> findAll() {
		
		// Get the data, but the order is not guaranteed
		Map<String, ?> notesMap = notePrefs.getAll();
		
		// Sort the data, oldest to newest based on alphanumeric sort 
		// of the date time value
		SortedSet<String> keys = new TreeSet<String>(notesMap.keySet());
		
		List<NoteDataItem> noteList = new ArrayList<NoteDataItem>();
		
		// Loop through the list of key values and deal with the keys one at a time
		for (String key : keys) {
			NoteDataItem note = new NoteDataItem();
			note.setDataItemKey(key);
			note.setDataItemValue((String) notesMap.get(key));
			noteList.add(note);
		}
		
		return noteList;
	}
	
	// function to update the existing note
	public boolean updateNote(NoteDataItem note) {
		
		SharedPreferences.Editor editor = notePrefs.edit();
		editor.putString(note.getDataItemKey(), note.getDataItemValue());
		editor.commit();
		
		return true;
	}
	
	// function to remove the existing note
	public boolean removeNote(NoteDataItem note) {
		
		if(notePrefs.contains(note.getDataItemKey())) {
			SharedPreferences.Editor editor = notePrefs.edit();
			editor.remove(note.getDataItemKey());
			editor.commit();
		}
		
		return true;
	}
}
