package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverState extends FlxTransitionableState
{
	var bfX:Float = 0;
	var bfY:Float = 0;
	

	public function new(x:Float, y:Float)
	{
		super();

		bfX = x;
		bfY = y;
	}

	override function create()
	{
		if (PlayState.OldMode == true)
		{
			var loser:FlxSprite = new FlxSprite(100, 100);
			var loseTex = FlxAtlasFrames.fromSparrow('assets/images/lose.png', 'assets/images/lose.xml');
			loser.frames = loseTex;
			loser.animation.addByPrefix('lose', 'lose', 24, false);
			loser.animation.play('lose');
			add(loser);
			
			var restart:FlxSprite = new FlxSprite(500, 50).loadGraphic('assets/images/restart.png');
			restart.setGraphicSize(Std.int(restart.width * 0.6));
			restart.updateHitbox();
			restart.alpha = 0;
			restart.antialiasing = true;
			add(restart);
			
			FlxTween.tween(restart, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
			FlxTween.tween(restart, {y: restart.y + 40}, 7, {ease: FlxEase.quartInOut, type: PINGPONG});
		}
		else
		{
			var bf:Boyfriend = new Boyfriend(bfX, bfY);
			// bf.scrollFactor.set();
			add(bf);
			bf.playAnim('firstDeath');

			FlxG.camera.follow(bf, LOCKON, 0.001);
		

			FlxG.sound.music.fadeOut(2, FlxG.sound.music.volume * 0.6);
		}
		

		

		super.create();
	}

	private var fading:Bool = false;

	override function update(elapsed:Float)
	{
		var pressed:Bool = FlxG.keys.justPressed.ENTER;
		var escaped:Bool = FlxG.keys.justPressed.BACKSPACE;
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (pressed && !fading)
		{
			fading = true;
			FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween)
			{
				FlxG.sound.music.stop();
				FlxG.switchState(new PlayState());
			});
		}
		
		if (escaped && !fading)
		{
			fading = true;
			if (PlayState.isStoryMode)
			{
				FlxG.switchState(new StoryMenuState());
			}
			else
			{
				FlxG.switchState(new FreeplayState());
			}
		}
		super.update(elapsed);
	}
}
