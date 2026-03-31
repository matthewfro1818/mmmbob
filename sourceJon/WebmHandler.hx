package;

import flixel.FlxG;
import openfl.display.Sprite;
#if desktop
import webm.*;
#end

class WebmHandler
{
	#if desktop
	public var webm:WebmPlayer;
	public var vidPath:String = "";
	public var io:WebmIo;
	public var initialized:Bool = false;
	public var wasHitOnce:Bool = false;
	public var renderedCount:Float = 0;
	
	public function new()
	{
	}
	
	public function source(?vPath:String):Void
	{
		if (vPath != null && vPath.length > 0)
		{
		vidPath = vPath;
		}
	}
	
	public function makePlayer():Void
	{
		io = new WebmIoFile(vidPath);
		webm = new WebmPlayer(io, false);
		webm.addEventListener(WebmEvent.PLAY, function(e) {
			onPlay();
		});
		webm.addEventListener(WebmEvent.COMPLETE, function(e) {
			onEnd();
		});
		webm.addEventListener(WebmEvent.STOP, function(e) {
			onStop();
		});
		webm.addEventListener(WebmEvent.RESTART, function(e) {
			onRestart();
		});
		webm.visible = false;
		initialized = true;
	}
	
	public function updatePlayer():Void
	{
		if (webm != null && webm.parent != null)
			webm.parent.removeChild(webm);

		initialized = false;
		makePlayer();
	}
	
	public function play():Void
	{
		if (initialized)
		{
			webm.play();
		}
	}
	
	public function stop():Void
	{
		if (initialized)
		{
			webm.stop();
		}
	}
	
	public function restart():Void
	{
		if (initialized)
		{
			webm.restart();
		}
	}
	
	public function update(elapsed:Float)
	{
		if (webm != null)
		{
			wasHitOnce = true;
			renderedCount += elapsed * 60;
		}

		webm.x = GlobalVideo.calc(0);
		webm.y = GlobalVideo.calc(1);
		webm.width = GlobalVideo.calc(2);
		webm.height = GlobalVideo.calc(3);
	}
	
	public var stopped:Bool = false;
	public var restarted:Bool = false;
	public var played:Bool = false;
	public var ended:Bool = false;
	public var paused:Bool = false;
	
	public function pause():Void
	{
		webm.stop();
		paused = true;
	}
	
	public function resume():Void
	{
		webm.play();
		paused = false;
	}
	
	public function togglePause():Void
	{
		if (paused)
		{
			resume();
		} else {
			pause();
		}
	}
	
	public function clearPause():Void
	{
		paused = false;
	}
	
	public function onStop():Void
	{
		stopped = true;
	}
	
	public function onRestart():Void
	{
		renderedCount = 0;
		wasHitOnce = false;
		restarted = true;
	}
	
	public function onPlay():Void
	{
		wasHitOnce = true;
		played = true;
	}
	
	public function onEnd():Void
	{
		trace("IT ENDED!");
		ended = true;
	}
	
	public function alpha():Void
	{
		webm.alpha = GlobalVideo.daAlpha1;
	}
	
	public function unalpha():Void
	{
		webm.alpha = GlobalVideo.daAlpha2;
	}
	
	public function hide():Void
	{
		webm.visible = false;
	}
	
	public function show():Void
	{
		webm.visible = true;
	}
	#else
	public var webm:Sprite;
	public function new()
	{
	trace("THIS IS ANDROID! or some shit...");
	}
	#end
}
