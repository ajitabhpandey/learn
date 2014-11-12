package info.ajitabhpandey.app.mysimplenotes;

import info.ajitabhpandey.app.mysimplenotes.data.NoteDataItem;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.EditText;

public class NoteItemEditorActivity extends Activity {
	
	private NoteDataItem note;

	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_note_item_editor);
		
		// Turns the laucher icon on the Activity Bar to options button
		getActionBar().setDisplayHomeAsUpEnabled(true);
		
		Intent intent = this.getIntent();
		note = new NoteDataItem();
		note.setDataItemKey(intent.getStringExtra("key"));
		note.setDataItemValue(intent.getStringExtra("text"));

		EditText etNoteItem = (EditText) findViewById(R.id.etNoteItem);
		etNoteItem.setText(note.getDataItemValue());
		etNoteItem.setSelection(note.getDataItemValue().length());
				
	}

	private void saveAndFinish() {
		EditText etNoteItem = (EditText) findViewById(R.id.etNoteItem);
		String noteText = etNoteItem.getText().toString();
		
		Intent intent = new Intent();
		intent.putExtra("key", note.getDataItemKey());
		intent.putExtra("text", noteText);
		setResult(RESULT_OK, intent);
		finish();
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		if (item.getItemId() == android.R.id.home) {
			saveAndFinish();
		}
		return false;
	}
	
	@Override
	public void onBackPressed() {
		saveAndFinish();
	}
}
