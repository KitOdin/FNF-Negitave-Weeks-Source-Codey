package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;



class WinState extends MusicBeatState
{

	var menuBG:FlxSprite;
	override function create()
	{
		menuBG = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		
		var WinText:FlxSprite = new FlxSprite();
		var winFrame = FlxAtlasFrames.fromSparrow('assets/images/ui/win.png', 'assets/images/ui/win.xml');
		WinText.frames = winFrame;
		WinText.screenCenter();
		WinText.animation.addByPrefix('boom', 'win!', 24, false);
		WinText.animation.play('boom');
		add(WinText);
		
		var HeaderText:Alphabet = new Alphabet(10, 10, "Congrats, You Won!", true, false);
		add(HeaderText);
		FlxG.sound.playMusic('assets/music/title' + TitleState.soundExt, 1);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		
		if (controls.ACCEPT)
		{
			FlxG.switchState(new MainMenuState());
		}
		
		if (controls.CHEAT)
		{
			var OOFY:Alphabet = new Alphabet(10, 50, "press c in a menu.", true, true);
			add(OOFY);
			var OOFYA:Alphabet = new Alphabet(10, 150, "hint its in a extra menu", true, true);
			add(OOFYA);
		}
	}
}