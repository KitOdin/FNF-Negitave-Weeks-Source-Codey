package ;
 
import flixel.system.FlxBasePreloader;
import openfl.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.Lib;
import flixel.FlxG;
 
@:bitmap("art/preloaderArt.png") class LogoImage extends BitmapData { }
 
class Preloader extends FlxBasePreloader
{
    public function new(MinDisplayTime:Float=3, ?AllowedURLs:Array<String>) 
    {
        super(MinDisplayTime, AllowedURLs);
    }
     
    var logo:Sprite;
     
    override function create():Void 
    {
        this._width = Lib.current.stage.stageWidth;
        this._height = Lib.current.stage.stageHeight;
         
        var ratio:Float = this._width / 2560; //This allows us to scale assets depending on the size of the screen.
         
        logo = new Sprite();
        logo.addChild(new Bitmap(new LogoImage(0,0)));
        addChild(logo); //Adds the graphic to the NMEPreloader's buffer.
		trace("F");
         
        super.create();
    }
     
    override function update(Percent:Float):Void 
    {
        super.update(Percent);
	}
}