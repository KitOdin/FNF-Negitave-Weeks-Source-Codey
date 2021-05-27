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



class IconSelectState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var characters:Array<String> = [
		"gf",
		"black",
		"locky",
		"monster",
		"tankman",
		"dad",
		"mom",
		"lucky",
		"unassigned",
		"monster",
		"senpai",
		"spooky",
		"spirit"
	];
	var CurrentCar:String = "unassigned";
	private var grpExtra:FlxTypedGroup<Alphabet>;
	var menuBG:FlxSprite;
	var icon:FlxSprite;
	override function create()
	{
		FlxG.mouse.visible = false;
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		
		menuBG.color = 0xFF88B8FF;
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		
		icon = new HealthIcon(CurrentCar);
		icon.setPosition(1000, 360);
		add(icon);
		var texty:FlxSprite = new FlxSprite(723, 26).loadGraphic('assets/images/ui/icons.png');
		texty.antialiasing = true;
		
		add(texty);
		grpExtra = new FlxTypedGroup<Alphabet>();
		add(grpExtra);
		//var iconGuide:Alphabet = new Alphabet(10, 10, "To use your icon, press the 4 key on your keyboard!", false, false);
		var iconGuide:FlxText = new FlxText(10, 10, 0, "To use your icon, press the 4 key on your keyboard!", 12);
		iconGuide.setFormat("TimKid", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(iconGuide);
		for (i in 0...characters.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, characters[i], true, false);
			controlLabel.isMenuItem = true;
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
			CurrentCar = characters[curSelected];
			icon.animation.play(CurrentCar);
			PlayState.customIconName = CurrentCar;
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
			//item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				//item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}