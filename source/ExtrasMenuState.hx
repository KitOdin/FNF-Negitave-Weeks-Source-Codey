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



class ExtrasMenuState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var ExtraContent:Array<String> = [
		"Animation Playground",
		"Scene Selector",
		"Customize Icon",
		"Bonus Images",
		"Sound Test",
		"Special Thanks"
	];
	
	var Colors:Array<String> = [
		"Magenta",
		"Deep Green",
		"Dark Red",
		"Light Blue",
		"Deep Grey",
		"Medium Grey"
	];
	
	private var grpExtra:FlxTypedGroup<Alphabet>;
	var menuBG:FlxSprite;
	var texty:FlxSprite;
	override function create()
	{
		FlxG.mouse.visible = false;
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesatD.png');
		
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		texty = new FlxSprite(771, 602).loadGraphic('assets/images/ui/extras.png');
		texty.setGraphicSize(Std.int(texty.width * 0.8));
		texty.updateHitbox();
		texty.antialiasing = true;
		
		add(texty);
		grpExtra = new FlxTypedGroup<Alphabet>();
		add(grpExtra);

		for (i in 0...ExtraContent.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, ExtraContent[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.lerpX = true;
			controlLabel.targetY = i;
			grpExtra.add(controlLabel);
			trace("Option Added");
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		super.create();
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			switch(ExtraContent[curSelected])
			{
				case "Animation Playground":
					FlxG.switchState(new AnimationDebugLoader());
				case "Scene Selector":
					FlxG.switchState(new SceneSelectorState());
				case "Customize Icon":
					FlxG.switchState(new IconSelectState());
				case "Bonus Images":
					FlxG.switchState(new FactsState());
				case "Sound Test":
					FlxG.switchState(new SoundTestState());
				case "Special Thanks":
					FlxG.switchState(new ThanksState());
			}
		}
		else
		{
			if (controls.BACK)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
		}
		
		switch(Colors[curSelected])
		{
			case "Magenta":
				menuBG.color = 0xFFea71fd;
			case "Deep Green":
				menuBG.color = 0xFF007F0E;
			case "Dark Red":
				menuBG.color = 0xFF7F0000;
			case "Light Blue":
				menuBG.color = 0xFF7F92FF;
			case "Deep Grey":
				menuBG.color = 0xFF404040;
			case "Medium Grey":
				menuBG.color = 0xFF808080;
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