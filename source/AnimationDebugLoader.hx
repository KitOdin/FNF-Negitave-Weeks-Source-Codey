package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIDropDownMenu;

using StringTools;

class AnimationDebugLoader extends MusicBeatState
{
	var menuBG:FlxSprite;
	var CharSelected:String = 'bf';
	override function create()
	{
		FlxG.mouse.visible = true;
		menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		var characters:Array<String> = CoolUtil.coolTextFile('assets/data/characterList.txt');

		var goBTN:FlxButton = new FlxButton(100, 30, 'Lets go!', enterPlayground);
		
		var player1DropDown = new FlxUIDropDownMenu(10, 100, FlxUIDropDownMenu.makeStrIdLabelArray(characters, true), function(character:String)
		{
			CharSelected = characters[Std.parseInt(character)];
		});
		player1DropDown.selectedLabel = CharSelected;
		
		
		add(player1DropDown);
		add(goBTN);
		
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			FlxG.switchState(new ExtrasMenuState());
		}
		super.update(elapsed);
	}
	function enterPlayground():Void
	{
		FlxG.switchState(new AnimationDebug(CharSelected));
	}
	
}