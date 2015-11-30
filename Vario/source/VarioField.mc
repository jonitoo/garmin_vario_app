//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.System as Sys;
using Toybox.Time as Time;

class DataField extends Ui.SimpleDataField {

    var lastAltitude=0;
    
    //! Constructor
    function initialize()
    {
        label = "VarioValue";
    }

    //! Handle the update event
    function compute(info)
    {
	    var diff = null;
	    if( info.altitude != null )
	    {
	    	diff = info.altitude - lastAltitude;
	    	lastAltitude = info.altitude;
	    }
	    return diff;
    }
}

//! main is the primary start point for a Monkeybrains application
class VarioField extends App.AppBase
{
    function onStart()
    {
        return false;
    }

    function getInitialView()
    {
        return [new DataField()];
    }

    function onStop()
    { 
        return false;
    }
}
