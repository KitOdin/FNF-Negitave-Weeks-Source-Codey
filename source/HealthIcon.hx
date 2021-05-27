package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	
	public var sprTracker:FlxSprite;
	
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		if (char == null)
		{
			char = 'unassigned';
		}
		if (char == 'what' || char == 'pref')
		{
			loadGraphic('assets/images/OptionIcons.png', true, 150, 150);
		}
		else
		{
			loadGraphic('assets/images/iconGrid.png', true, 150, 150);
		}
		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-hyper', [0, 1], 0, false, isPlayer);
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('head', [10, 11], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17, 18], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		animation.add('joshua', [24, 25], 0, false, isPlayer);
		animation.add('locky', [26, 27], 0, false, isPlayer);
		animation.add('black', [28, 29], 0, false, isPlayer);
		animation.add('lucky', [30, 31], 0, false, isPlayer);
		animation.add('bf-grafix', [32, 33], 0, false, isPlayer);
		animation.add('lol', [36, 37], 0, false, isPlayer);
		animation.add('unassigned', [34, 35], 0, false, isPlayer);
		
		animation.add('what', [0, 0], 0, false, isPlayer);
		animation.add('pref', [1, 1], 0, false, isPlayer);
		animation.play(char);
		scrollFactor.set();
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
