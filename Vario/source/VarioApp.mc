//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.Application as App;
using Toybox.Position as Position;

class VarioApp extends App.AppBase {

    var varioView;
    var varioValue = 0;
    var lastAltitude = 0;

    //! onStart() is called on application start up
    function onStart() {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    //! onStop() is called when your application is exiting
    function onStop() {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition(info) {
        varioView.setPosition(info);
    }

    //! Return the initial view of your application here
    function getInitialView() {
        varioView = new VarioView();
        return [ varioView ];
    }

}