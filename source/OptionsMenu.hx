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
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var settings:Array<String> = [
		"Agonizing Speed",
		"Max Fov",
		"Comically Slow Speed",
		"WTF Mode"
	];
	
	var optionsSetted:Array<Bool> = [
		false,
		false,
		false,
		false
	];
	
	private var grpControls:FlxTypedGroup<Alphabet>;
	
	var Agony:Bool;
	var FovMax:Bool;
	var Slowness:Bool;
	var WHAT:Bool;
	var optionsToggled:FlxText;
	var NextColor:FlxColor = 0xFF69FF69;
	var PrevColor:FlxColor;
	var CurrentColor:FlxColor = 0xFF22995E;
	var menuBG:FlxSprite;
	override function create()
	{
		if (FlxG.save.data.agony == null)
		{
			FlxG.save.data.agony = false;
		}
		else if (FlxG.save.data.fov == null)
		{
			FlxG.save.data.fov = false;
		}
		else if (FlxG.save.data.slow == null)
		{
			FlxG.save.data.slow = false;
		}
		else if (FlxG.save.data.what == null)
		{
			FlxG.save.data.what = false;
		}
		
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesatC.png');
		
		menuBG.color = 0xFF22995E;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		optionsToggled = new FlxText(10, 10, 0, "e", 22);
		optionsToggled.setFormat("TimKid", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(optionsToggled);
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

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		optionsToggled.text = settings[curSelected] + " : " + optionsSetted[curSelected];
		if (controls.ACCEPT)
		{
			switch(settings[curSelected])
			{
				case "Agonizing Speed":
					FlxG.save.data.agony = !FlxG.save.data.agony;
					
				case "Max Fov":
					FlxG.save.data.fov = !FlxG.save.data.fov;
					
				case "Comically Slow Speed":
					FlxG.save.data.slow = !FlxG.save.data.slow;
					
				case "WTF Mode":
					FlxG.save.data.what = !FlxG.save.data.what;
					
			}
			
			Agony = PlayState.AgonyMod;
			FovMax = PlayState.FovMaxMod;
			Slowness = PlayState.SlownessMod;
			WHAT = PlayState.wutMode;
			
			
		}
		
		//Option Save Data
		Agony = FlxG.save.data.agony;
		FovMax = FlxG.save.data.fov;
		Slowness = FlxG.save.data.slow;
		WHAT = FlxG.save.data.what;
		
		
		//Playstate Crap
		PlayState.AgonyMod = Agony;
		optionsSetted[0] = Agony;
		PlayState.FovMaxMod = FovMax;
		optionsSetted[1] = FovMax;
		PlayState.SlownessMod = !Slowness;
		optionsSetted[2] = !Slowness;
		PlayState.wutMode = !WHAT;
		optionsSetted[3] = !WHAT;
		
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
		
		PrevColor = CurrentColor;
		CurrentColor = NextColor;
		NextColor = PrevColor;
		menuBG.color = CurrentColor;
		
		
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
