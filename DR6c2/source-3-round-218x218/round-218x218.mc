using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

//! inherit from the view that contains the commonlogic
class DeviceView extends PowerView {
	var myTime;
	var strTime;
	
	//! it's good practice to always have an initialize, make sure to call your parent class here!
    function initialize() {
        PowerView.initialize();
    }

	function onUpdate(dc) {
		//! call the parent function in order to execute the logic of the parent
		PowerView.onUpdate(dc);

		//! Draw separator lines
        dc.setColor(mColourLine, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);

        //! Horizontal dividers
        dc.drawLine(30,  26,  185, 26);
        dc.drawLine(0,   84,  215, 84);
        dc.drawLine(0,   142, 215, 142);
        dc.drawLine(50, 202, 175, 202);

        //! Top vertical divider
        dc.drawLine(109, 28,  109, 84);

        //! Centre vertical divider
        dc.drawLine(149, 84,  149, 142);

        //! Bottom vertical divider
        dc.drawLine(109, 142, 109, 202);
        
        //! Display GPS accuracy
		dc.setColor(mGPScolor, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(9, 5, 60, 21); 
		if (uMilClockAltern == 1) {
		   dc.fillRectangle(164, 5, 50, 21);
		} else {
		   dc.fillRectangle(149, 5, 50, 21);
		}
		
        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);
		//! Show number of laps or clock with current time in top
		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
		if (uMilClockAltern == 0) {		
			dc.drawText(108, -4, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		}

		//! Display metrics		
		for (var i = 1; i < 7; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"062,062,064,007,072,062,035");
	       	} else if ( i == 2 ) {	//!upper row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"154,062,163,110,050,152,035");
	       	} else if ( i == 3 ) {  //!middle row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"082,111,090,018,124,009,130");
	       	} else if ( i == 4 ) {  //!middle row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"183,119,000,000,000,183,092");
	       	} else if ( i == 5 ) {	//!lower row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"063,162,064,008,152,073,191");
	       	} else if ( i == 6 ) {	//!lower row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"150,162,163,109,175,140,191");
       		}        	
		}

		if (jTimertime == 0) {
	    	if (uShowRedClock == true) {
		    	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
				dc.drawText(109, 140, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		    }
		}

		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(87, 204, 44, 11);
		dc.fillRectangle(131, 207, 3, 5);
		
		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 89 + pwr*0.4  ;
		var Endstatuspwrbr = 40 - pwr*0.4 ;
		dc.fillRectangle(Startstatuspwrbr, 206, Endstatuspwrbr, 7);	
   
	}

}