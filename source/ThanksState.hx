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



class ThanksState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var specialThankz:Array<String>;
	
	private var grpExtra:FlxTypedGroup<Alphabet>;
	var menuBG:FlxSprite;
	var texty:FlxSprite;
	override function create()
	{
		FlxG.mouse.visible = false;
		specialThankz = CoolUtil.coolTextFile('assets/data/specialThanks.txt');
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		
		menuBG.color = 0xFFA120D8;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		grpExtra = new FlxTypedGroup<Alphabet>();
		add(grpExtra);

		for (i in 0...specialThankz.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, specialThankz[i], true, false);
			controlLabel.isMenuItem = true;
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
		
		
		if (controls.BACK)
		{
			FlxG.switchState(new ExtrasMenuState());
		}
		if (controls.CHEAT)
		{
			FlxG.sound.play('assets/sounds/ANGRY' + TitleState.soundExt, 1);
			var controlLabel:Alphabet = new Alphabet(0, 2480, "press H on the main menu lol", true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = 35;
			grpExtra.add(controlLabel);
		}
		else
		{
			if (controls.UP_P)
			{
				changeSelection( -1);
			}
			if (controls.DOWN_P)
			{
				changeSelection(1);
			}
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