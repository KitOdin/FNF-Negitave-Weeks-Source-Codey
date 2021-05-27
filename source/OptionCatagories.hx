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

class OptionCatagories extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var settings:Array<String> = [
		"Funkiness",
		"Prefrences"
	];
	
	var IconMetaData:Array<String> = [
		"what",
		"pref"
	];
	
	
	private var grpControls:FlxTypedGroup<Alphabet>;
	
	
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
		var texty:FlxSprite = new FlxSprite(662, 70).loadGraphic('assets/images/ui/options.png');
		texty.setGraphicSize(Std.int(texty.width * 0.8));
		texty.updateHitbox();
		texty.antialiasing = true;
		
		add(texty);
		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...settings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, settings[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			trace("Option Added");
			
			var icon:HealthIcon = new HealthIcon(IconMetaData[i]);
			icon.sprTracker = controlLabel;
			
			add(icon);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (controls.ACCEPT)
		{
			switch(settings[curSelected])
			{
				case "Funkiness":
					FlxG.switchState(new OptionsMenu());
				case "Prefrences":
					FlxG.switchState(new Prefrences());
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
