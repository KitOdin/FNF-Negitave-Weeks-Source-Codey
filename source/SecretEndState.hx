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



class SecretEndState extends MusicBeatState
{

	var menuBG:FlxSprite;
	override function create()
	{
		menuBG = new FlxSprite(0, 0).loadGraphic('assets/images/ui/peanut.png');
		add(menuBG);
		FlxG.sound.playMusic('assets/music/qwerty' + TitleState.soundExt, 1);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		
		if (controls.ACCEPT)
		{
			FlxG.sound.music.stop();
			FlxG.switchState(new MainMenuState());
		}
	}
}