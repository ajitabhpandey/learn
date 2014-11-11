package info.ajitabhpandey.app.mysimplenotes.data;

import android.annotation.SuppressLint;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class NoteDataItem {
	
	private String dataItemKey;
	private String dataItemValue;
	
	// getter and setter functions to initialize the private variables
	// and to obtain the values stored in these private variables
	public String getDataItemKey() {
		return dataItemKey;
	}
	public void setDataItemKey(String dataItemKey) {
		this.dataItemKey = dataItemKey;
	}
	public String getDataItemValue() {
		return dataItemValue;
	}
	public void setDataItemValue(String dataItemValue) {
		this.dataItemValue = dataItemValue;
	}
	
	@SuppressLint("SimpleDateFormat") 
	public static NoteDataItem getNew() {
		Locale locale = new Locale("en_US");
		Locale.setDefault(locale);
		
		// Date time value for the key
		String pattern = "yyyy-MM-dd HH:mm:ss Z";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		String dataItemKey = formatter.format(new Date());
		
		NoteDataItem notedataitem = new NoteDataItem();
		notedataitem.setDataItemKey(dataItemKey);
		notedataitem.setDataItemValue("");
		
		return notedataitem;
	}
	
	@Override
	public String toString() {
		return this.getDataItemValue();
	}
}
