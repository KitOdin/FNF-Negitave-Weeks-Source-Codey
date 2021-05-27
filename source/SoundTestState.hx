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



class SoundTestState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var sfxs:Array<String> = [
		"ANGRY",
		"fnf_loss_sfx",
		"confirmMenu",
		"clickText",
		"introGo",
		"freshIntro",
		"Lights_Turn_On",
		"Senpai_Dies",
		"cancelMenu",
		"GF_"
	];
	var CurrentCar:String = "unassigned";
	private var grpExtra:FlxTypedGroup<Alphabet>;
	var menuBG:FlxSprite;
	var icon:FlxSprite;
	
	
	//Images
	var zzzz:FlxSprite;
	var loly:FlxSprite;
	var CamBoi:FlxSprite;
	var bsidey:FlxSprite;
	var secretlol:FlxSprite;
	var iconGuide:Alphabet;
	
	override function create()
	{
		FlxG.mouse.visible = false;
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		
		menuBG.color = 0xFFF9FBF1;
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		
		
		grpExtra = new FlxTypedGroup<Alphabet>();
		add(grpExtra);
		iconGuide = new Alphabet(0, 70, "Press the z key to play a sound", false, false);
		//iconGuide = new FlxText(10, 10, 0, "Press the enter key to play the currently selected sound!", 12);
		//iconGuide.setFormat("TimKid", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(iconGuide);
		for (i in 0...sfxs.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, sfxs[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpExtra.add(controlLabel);
			trace("Option Added");
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}
		FlxG.sound.music.stop();
		changeSelection(0);
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			switch(sfxs[curSelected])
			{
				case "GF_":
					FlxG.sound.play('assets/sounds/GF_' + FlxG.random.int(1, 4) + TitleState.soundExt, 1);
				default:
					FlxG.sound.play('assets/sounds/' + sfxs[curSelected] + TitleState.soundExt, 1);
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
			//item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				//item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}