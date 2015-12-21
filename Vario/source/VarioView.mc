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

class PositionSampleView extends Ui.View {

    var posnInfo = null;
    var lastAltitude = 0;
    
    var vibrateData = [
                        new Attention.VibeProfile(  25, 100 ),
                        new Attention.VibeProfile(  50, 100 ),
                        new Attention.VibeProfile(  75, 100 ),
                        new Attention.VibeProfile( 100, 100 ),
                        new Attention.VibeProfile(  75, 100 ),
                        new Attention.VibeProfile(  50, 100 ),
                        new Attention.VibeProfile(  25, 100 )
                      ];
                      
    var vibrateData2 = [
                        new Attention.VibeProfile( 100, 100 )
                      ];
                      
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
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        if( posnInfo != null ) {
        
        	// vario (4 m/s is good)
        	var varioValue = posnInfo.altitude - lastAltitude;   
        	lastAltitude = posnInfo.altitude;
        	//dc.setColor( Gfx );
            dc.drawText( dc.getWidth() / 2, 20 , Gfx.FONT_LARGE, varioValue.toString() + " m/s", Gfx.TEXT_JUSTIFY_CENTER );
            
            // altitude
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 20), Gfx.FONT_SMALL, posnInfo.altitude.toString() + " müM", Gfx.TEXT_JUSTIFY_CENTER );

			// vibration
            if(varioValue > 0) {
        		Attention.vibrate([new Attention.VibeProfile(varioValue, 100 )]);
        	}
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

    function setPosition(info) {
        posnInfo = info;
        Ui.requestUpdate();
    }

}
