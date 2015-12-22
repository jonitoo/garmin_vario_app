//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Attention as Attention;

class VarioView extends Ui.View {

    var posnInfo = null;
    var clockTime = null; //ms
    var lastAltitude = 0;
    var timestamp = 0;
    var lastTimestamp = 0;
                      
    //! Load your resources here
    function onLayout(dc) {
    }

    function onHide() {
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {	
 
        // Set background color
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        
        if( posnInfo != null ) {
        
			// change in altitude since last update
        	var intervalAltitude = posnInfo.altitude - lastAltitude;   // in m

			// change in time since last update
        	var intervalTime = timestamp.toFloat() - lastTimestamp.toFloat(); // usually around 1000 in ms

        	// vario is increase in altitude per time
			var varioValue = 0;
			var intervalTimeSec = intervalTime.toFloat() / 1000;
			varioValue = (intervalAltitude / intervalTimeSec);
        	var varioValueFormatted = varioValue.toDouble().format("%0.2f");
        	
        	// print vario
        	if(varioValue >= 0) {
	        	dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        	} else {
        		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        	}
            dc.drawText(dc.getWidth() / 2, 20 , Gfx.FONT_LARGE, varioValueFormatted.toString() + " m/s", Gfx.TEXT_JUSTIFY_CENTER );
            
            // print altitude
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 10), Gfx.FONT_SMALL, posnInfo.altitude.toDouble().format("%0.2f").toString() + " m", Gfx.TEXT_JUSTIFY_CENTER );

			// vibration
            if(varioValue > 0) {
        		Attention.vibrate([new Attention.VibeProfile(varioValue, 100 )]);
        	}
        	
        	// update data
        	lastAltitude = posnInfo.altitude;
			lastTimestamp = timestamp;
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

	// set the positions for a given timestamp 
    function setPosition(info, time) {
        posnInfo = info; 
        timestamp = time;
        Ui.requestUpdate();
    }
    
}
