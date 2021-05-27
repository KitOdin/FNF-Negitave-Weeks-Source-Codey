package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

import flixel.graphics.frames.FlxAtlasFrames;
using StringTools;



class FactsState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var imageBois:Array<String> = [
		"zzzzzzzz",
		"lol",
		"Cam",
		"fnflol"
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
	var iconGuide:FlxText;
	
	override function create()
	{
		FlxG.mouse.visible = false;
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		
		menuBG.color = 0xFFB6FF00;
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		
		
		grpExtra = new FlxTypedGroup<Alphabet>();
		add(grpExtra);
		//var iconGuide:Alphabet = new Alphabet(10, 10, "To use your icon, press the 4 key on your keyboard!", false, false);
		iconGuide = new FlxText(10, 10, 0, "Current Image : zzzzzzzz.png", 22);
		iconGuide.setFormat("TimKid", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(iconGuide);
		for (i in 0...imageBois.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, imageBois[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpExtra.add(controlLabel);
			trace("Option Added");
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}
		
		//Assign it, resize, set its positon, repeat.
		
		zzzz = new FlxSprite(0, 0).loadGraphic('assets/images/zzzzzzzz.png');
		zzzz.setGraphicSize(Std.int(zzzz.width * 0.25));
		zzzz.setPosition(629, 387);
		
		loly = new FlxSprite(0, 0).loadGraphic('assets/images/lol.png');
		loly.setPosition(821, 244);
		
		CamBoi = new FlxSprite(0, 0).loadGraphic('assets/images/Cam.png');
		CamBoi.setGraphicSize(Std.int(CamBoi.width * 0.7));
		CamBoi.setPosition(777, 50);
		
		secretlol = new FlxSprite(0, 0).loadGraphic('assets/images/fnflol.png');
		secretlol.setGraphicSize(Std.int(secretlol.width * 0.2));
		secretlol.setPosition(581, 86);
		
		
		zzzz.visible = true;
		loly.visible = false;
		CamBoi.visible = false;
		secretlol.visible = false;
		
		add(zzzz);
		add(loly);
		add(CamBoi);
		add(secretlol);
		FlxG.sound.music.stop();
		FlxG.sound.playMusic('assets/music/title' + TitleState.soundExt);
		
		var texB = FlxAtlasFrames.fromSparrow('assets/images/backspace.png', 'assets/images/backspace.xml');
		var backspace:FlxSprite = new FlxSprite(966, 597);
		backspace.frames = texB;
		backspace.animation.addByPrefix('idle', "backspace to exit", 24);
		backspace.animation.play('idle');
		backspace.scrollFactor.set();
		backspace.antialiasing = true;
		add(backspace);
		
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			switch(imageBois[curSelected])
			{
				case "zzzzzzzz":
					zzzz.visible = true;
					loly.visible = false;
					CamBoi.visible = false;
					secretlol.visible = false;
				case "lol":
					zzzz.visible = false;
					loly.visible = true;
					CamBoi.visible = false;
					secretlol.visible = false;
				case "Cam":
					zzzz.visible = false;
					loly.visible = false;
					CamBoi.visible = true;
					secretlol.visible = false;
				case "bsidedness":
					zzzz.visible = false;
					loly.visible = false;
					CamBoi.visible = false;
					secretlol.visible = false;
				case "fnflol":
					zzzz.visible = false;
					loly.visible = false;
					CamBoi.visible = false;
					secretlol.visible = true;

			}
			iconGuide.text = "Current Image : " + imageBois[curSelected] + ".png";
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