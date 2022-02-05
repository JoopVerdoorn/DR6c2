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
        
		//! Conditions for showing the demoscreen       
        if (uShowDemo == false) {
        	if (licenseOK == false && jTimertime > 900)  {
        		uShowDemo = true;        		
        	}
        }

	   //! Check whether demoscreen is showed or the metrics 
	   if (uShowDemo == false ) {

		//! Draw separator lines
        dc.setColor(mColourLine, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);

        //! Horizontal thirds
        dc.drawLine(0,   63,  215, 63);
        dc.drawLine(0,   122, 215, 122);

        //! Top vertical divider
        dc.drawLine(107, 26,  107, 63);

        //! Centre vertical divider
        dc.drawLine(149, 63,  149, 122);

        //! Bottom vertical divider
        dc.drawLine(107, 122, 107, 180);
                
        //! Bottom horizontal divider
        dc.drawLine(50, 202, 175, 202);

        //! Top centre mini-field separator
		dc.drawRoundedRectangle(72, -10, 72, 36, 4);

		//! Display metrics
        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"); 		
		//! Show clock with current time in top
		if (uMilClockAltern == 0) {	
			dc.drawText(98, -4, Graphics.FONT_NUMBER_MILD, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		}


		for (var i = 1; i < 7; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"062,041,065,015,047,052,015");
	       	} else if ( i == 2 ) {	//!upper row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"154,041,160,111,047,168,015");
	       	} else if ( i == 3 ) {  //!middle row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"085,090,090,025,101,014,110");
	       	} else if ( i == 4 ) {  //!middle row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"180,100,000,000,000,181,071");
	       	} else if ( i == 5 ) {	//!lower row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"062,143,066,017,139,072,171");
	       	} else if ( i == 6 ) {	//!lower row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"150,143,158,111,149,148,171");
       		}      	
		}


		//! Top battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(125, 3, 15, 19);
		dc.fillRectangle(128, 1, 9, 3);
		
		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Endstatuspwrbr = 0.15*(100-pwr)  ;
		var Startstatuspwrbr = 5  ;
		dc.fillRectangle(127, Startstatuspwrbr, 11, Endstatuspwrbr);

	   } else {
	   //! Display demo screen
		dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);
	
		if (licenseOK == true) {
      		dc.drawText(109, 36, Graphics.FONT_XTINY, "DR6c2", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(109, 100, Graphics.FONT_MEDIUM, "Registered !!", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(74, 125, Graphics.FONT_XTINY, "License code: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(164, 125, Graphics.FONT_XTINY, mtest, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);		
		} else {
      		dc.drawText(109, 15, Graphics.FONT_XTINY, "License needed !!", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      		dc.drawText(109, 37, Graphics.FONT_XTINY, "Run is recorded though", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(55, 75, Graphics.FONT_MEDIUM, "ID 0: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(146, 69, Graphics.FONT_NUMBER_MEDIUM, ID0, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(55, 112, Graphics.FONT_MEDIUM, "ID 1: " , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(146, 105, Graphics.FONT_NUMBER_MEDIUM, ID1, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(55, 148, Graphics.FONT_MEDIUM, "ID 2: " , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(146, 142, Graphics.FONT_NUMBER_MEDIUM, ID2, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      	}
	   }
	   
	}

}