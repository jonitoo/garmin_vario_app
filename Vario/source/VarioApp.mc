using Toybox.Application as App;
using Toybox.Sensor as Sensor;
using Toybox.System as Sys;

class VarioApp extends App.AppBase {

    var varioView;
    var dataTimer;
    var updateInterval = 500;

    //! onStart() is called on application start up
    function onStart() {
        dataTimer = new Timer.Timer();
        dataTimer.start( method(:timerCallback), updateInterval, true );
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }
	
	function timerCallback() {
		varioView.setSensorInfo(Sensor.getInfo(),  updateInterval);
	}
    
    //! Return the initial view of your application here
    function getInitialView() {
        varioView = new VarioView();
        varioView.setSensorInfo(Sensor.getInfo(), updateInterval);
        return [ varioView ];
    }
}