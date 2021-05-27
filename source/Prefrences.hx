package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.Lib;
import lime.utils.Assets;

class Prefrences extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;
	public static var speedOffset:Float = 0.0;
	var settings:Array<String> = [
		"Scroll Speed Offset",
		"FPS Counter",
		"Downscroll"
	];
	
	
	private var grpControls:FlxTypedGroup<Alphabet>;
	var speedy:FlxText;
	
	var menuBG:FlxSprite;
	override function create()
	{
		
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesatC.png');
		
		menuBG.color = 0xFF22995E;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		
		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...settings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, settings[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			trace("Option Added");
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}
		speedy = new FlxText(10, 10, 0, "e", 22);
		speedy.setFormat("TimKid", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(speedy);
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		speedy.text = "Speed Offset : " + speedOffset;
		if (controls.ACCEPT)
		{
			switch(settings[curSelected])
			{
				case "FPS Counter":
					FlxG.save.data.fps = !FlxG.save.data.fps;
					(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
				case "Downscroll":
					FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
			}
			
			
		}

		if (isSettingControl)
			waitingInput();
		else
		{
			if (controls.BACK)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
			if (settings[curSelected] == "Scroll Speed Offset")
			{
				if (controls.LEFT_P)
					speedOffset -= 0.1;
				if (controls.RIGHT_P)
					speedOffset += 0.1;
			}
		}
	}

	function waitingInput():Void
	{
		if (FlxG.keys.getIsDown().length > 0)
		{
			PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxG.keys.getIsDown()[0].ID, null);
		}
		// PlayerSettings.player1.controls.replaceBinding(Control)
	}

	var isSettingControl:Bool = false;

	function changeBinding():Void
	{
		if (!isSettingControl)
		{
			isSettingControl = true;
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		NGio.logEvent('Fresh');
		#end
		
		
		
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;
		

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
