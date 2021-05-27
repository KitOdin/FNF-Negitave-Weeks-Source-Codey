package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

import lime.utils.Assets;

using StringTools;



class EndingState extends MusicBeatState
{
	var TBCScreen:FlxSprite;
	var Benchy:FlxSprite;
	var boyfriend:Character;
	
	override function create()
	{
		FlxG.sound.music.stop();
		FlxG.sound.playMusic('assets/music/Pobeepo' + TitleState.soundExt, 0);
		FlxG.sound.music.fadeIn(1, 0, 0.8);
		Conductor.changeBPM(100);
		super.create();
		var bg:FlxSprite = new FlxSprite(-255, -126).loadGraphic('assets/images/negitave/outside/outsideBG.png');
		bg.antialiasing = true;
		add(bg);
		
		var FG:FlxSprite = new FlxSprite(0, 0).loadGraphic('assets/images/negitave/roadBG.png');
		FG.antialiasing = true;
		add(FG);
		boyfriend = new Character(833, 140, 'bf', true);
		boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.5));
		createBench();
		add(Benchy);
		add(boyfriend);
		TBCScreen = new FlxSprite(0, 0).loadGraphic('assets/images/ui/ToBeContinuedMessage.png');
		TBCScreen.alpha = 0;
		add(TBCScreen);
		
		new FlxTimer().start(1.9, function(tmr:FlxTimer)
		{
			FlxG.sound.play('assets/sounds/ahem' + TitleState.soundExt, 1);
		});
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			Benchy.animation.play('oof', true);
			Benchy.setPosition(283, 84);
			boyfriend.playAnim('scared', true);
		});
		
		new FlxTimer().start(4.25, function(tmr:FlxTimer)
		{
			new FlxTimer().start(0.3, function(tmrr:FlxTimer)
			{
				TBCScreen.alpha += 0.15;

				if (TBCScreen.alpha < 1)
				{
					tmrr.reset(0.3);
				}
				else
				{
					new FlxTimer().start(1, function(tmrrr:FlxTimer)
					{
						FlxG.switchState(new WinState());
					});
				}
			});
		});
	}
	
	function createBench()
	{
		Benchy = new FlxSprite(283, 81);
		Benchy.frames = FlxAtlasFrames.fromSparrow('assets/images/negitave/cutscenes/Bench_assets.png', 'assets/images/negitave/cutscenes/Bench_assets.xml');
		Benchy.animation.addByPrefix('idle', 'vibin', 24, true);
		Benchy.animation.addByPrefix('oof', 'Stoked', 24, false);
		Benchy.animation.play('idle');
	}
}