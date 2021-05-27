package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;



class SceneSelectorState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var Scenes:Array<String> = [
		"Title",
		"Menu",
		"Freeplay",
		"AnimationDebugLoader",
		"Story",
		"Options",
		"Extras",
		"Latency"
	];

	private var grpExtra:FlxTypedGroup<Alphabet>;
	var menuBG:FlxSprite;
	
	override function create()
	{
		FlxG.mouse.visible = false;
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		
		menuBG.color = 0xFF47E9FF;
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		
		#if debug
		Scenes.push('Ending');
		#end
		
		grpExtra = new FlxTypedGroup<Alphabet>();
		add(grpExtra);

		for (i in 0...Scenes.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, Scenes[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.lerpX = true;
			controlLabel.targetY = i;
			grpExtra.add(controlLabel);
			trace("Option Added");
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}
		FlxG.sound.music.stop();
		FlxG.sound.playMusic('assets/music/breakfast' + TitleState.soundExt);
		
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			switch(Scenes[curSelected])
			{
				case "Title":
					FlxG.switchState(new TitleState());
				case "Menu":
					FlxG.switchState(new MainMenuState());
				case "Freeplay":
					FlxG.switchState(new FreeplayState());
				case "AnimationDebugLoader":
					FlxG.switchState(new AnimationDebugLoader());
				case "Story":
					FlxG.switchState(new StoryMenuState());
				case "Options":
					FlxG.switchState(new OptionsMenu());
				case "Extras":
					FlxG.switchState(new ExtrasMenuState());
				case "Ending":
					FlxG.switchState(new EndingState());
				case "Latency":
					FlxG.switchState(new LatencyState());
			}
		}
		else
		{
			if (controls.BACK)
				FlxG.switchState(new ExtrasMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
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
			curSelected = grpExtra.length - 1;
		if (curSelected >= grpExtra.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;
		

		var bullShit:Int = 0;

		for (item in grpExtra.members)
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