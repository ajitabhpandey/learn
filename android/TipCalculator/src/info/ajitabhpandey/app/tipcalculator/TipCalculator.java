package info.ajitabhpandey.app.tipcalculator;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class TipCalculator extends Activity {

	public EditText etAmount;
	public TextView tvTipAmount;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tip_calculator);
        etAmount = (EditText) findViewById(R.id.etAmount);
        tvTipAmount = (TextView) findViewById(R.id.tvTipAmount);
        
        Button btnTenPercent = (Button) findViewById(R.id.btnTenPercent);
        btnTenPercent.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				tvTipAmount.setText("$" + calculateTipAmount(Integer.parseInt(etAmount.getText().toString()), 10));
				
			}

		});
        
        Button btnFifteenPercent = (Button) findViewById(R.id.btnFifteenPercent);
        btnFifteenPercent.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				tvTipAmount.setText("$" + calculateTipAmount(Integer.parseInt(etAmount.getText().toString()), 15));
				
			}
		});
        
        Button btnTwentyPercent = (Button) findViewById(R.id.btnTwentyPercent);
        btnTwentyPercent.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				tvTipAmount.setText("$" + calculateTipAmount(Integer.parseInt(etAmount.getText().toString()), 20));
				
			}
		});
    }
    
	private int calculateTipAmount(int transactionAmount, int percentage) {
		return (transactionAmount * percentage)/100;
	}
}
