using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Attention as Attention;

class VarioView extends Ui.View {

	var sensorInfo = null;
	var altitude = null;
    var lastAltitude = 0;
    var updateInterval = 0;
    var HR_graph;
    
    //! Constructor
    function initialize()
    {
        HR_graph = new LineGraph( 20, 10, Gfx.COLOR_WHITE );
    }
                      
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
                
        if(sensorInfo has :altitude && sensorInfo.altitude != null ) {
        
        	// get altitude from baro sensor
        	var altitude = sensorInfo.altitude;   // in m, float
	
			// change in altitude since last position update
        	var intervalAltitude = sensorInfo.altitude - lastAltitude;   // in m
			
        	// vario is increase in altitude per time (meter per second)
			var varioValue = 0;
			if(updateInterval != 0) {
				varioValue = (intervalAltitude.toDouble() / (updateInterval.toDouble() / 1000));
			}
			
			// handle vibration
            if(varioValue > 0) {
        		Attention.vibrate([new Attention.VibeProfile(varioValue * 20, 50)]);
        	} 

        	// print vario
        	if(varioValue >= 0) {
	        	dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        	} else if (varioValue == 0) {
        		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        	} else {
        		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        	}
            dc.drawText(dc.getWidth() / 2, 20 , Gfx.FONT_LARGE, varioValue.toDouble().format("%0.2f").toString() + " m/s", Gfx.TEXT_JUSTIFY_CENTER );

            // print altitude
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(dc.getWidth() / 2, ((dc.getHeight() / 2) + 10), Gfx.FONT_SMALL, altitude.toDouble().format("%0.2f").toString() + " m", Gfx.TEXT_JUSTIFY_CENTER );
        	
        	// draw graph
			HR_graph.addItem(altitude);
        	HR_graph.draw( dc, [5,30], [200,129] );
        	
        	// update data 
        	lastAltitude = altitude;
        }
        else {
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_SMALL, "Baro info not available", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

	// update altiude
    function setSensorInfo(sensorInfoX, updateIntervalX) {
        sensorInfo = sensorInfoX;
        updateInterval = updateIntervalX;
        Ui.requestUpdate();
    }
 
}
