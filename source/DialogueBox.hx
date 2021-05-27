package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;
	var isPixel:String = 'no';
	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitHead:FlxSprite;
	var portraitBox:FlxSprite;
	var portraitLock:FlxSprite;
	var portraitJosh:FlxSprite;
	var portraitSock:FlxSprite;
	
	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	
	var portChar:String = '';
	var charDia:String = '';

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic('assets/music/Lunchbox' + TitleState.soundExt, 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic('assets/music/LunchboxScary' + TitleState.soundExt, 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'ridge' | 'viday' | 'lockers':
				FlxG.sound.playMusic('assets/music/Cowbellody' + TitleState.soundExt, 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'void' | 'colors' | 'test':
				FlxG.sound.playMusic('assets/music/Pobeepo' + TitleState.soundExt, 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = FlxAtlasFrames.fromSparrow('assets/images/portraits/senpaiPortrait.png', 'assets/images/portraits/senpaiPortrait.xml');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
		
		portraitHead = new FlxSprite(143, 259);
		portraitHead.frames = FlxAtlasFrames.fromSparrow('assets/images/portraits/headPort.png', 'assets/images/portraits/headPort.xml');
		portraitHead.animation.addByPrefix('enter', 'Head Portrait Enter', 24, false);
		portraitHead.animation.addByPrefix('enterAlt', 'Head Unpleased Portrait Enter', 24, false);
		portraitHead.updateHitbox();
		portraitHead.scrollFactor.set();
		add(portraitHead);
		portraitHead.visible = false;
		
		
		portraitBox = new FlxSprite(163, 259);
		portraitBox.frames = FlxAtlasFrames.fromSparrow('assets/images/portraits/boxPort.png', 'assets/images/portraits/boxPort.xml');
		portraitBox.animation.addByPrefix('enter', 'Box Portrait Enter', 24, false);
		portraitBox.updateHitbox();
		portraitBox.scrollFactor.set();
		add(portraitBox);
		portraitBox.visible = false;
		
		
		portraitLock = new FlxSprite(163, 159);
		portraitLock.frames = FlxAtlasFrames.fromSparrow('assets/images/portraits/lockPort.png', 'assets/images/portraits/lockPort.xml');
		portraitLock.animation.addByPrefix('enter', 'Locky Portrait Enter', 24, false);
		portraitLock.animation.addByPrefix('enterAlt', 'Locky Phased Portrait Enter', 24, false);
		portraitLock.updateHitbox();
		portraitLock.scrollFactor.set();
		add(portraitLock);
		portraitLock.visible = false;
		
		
		portraitJosh = new FlxSprite(193, 252);
		portraitJosh.frames = FlxAtlasFrames.fromSparrow('assets/images/portraits/joshPort.png', 'assets/images/portraits/joshPort.xml');
		portraitJosh.animation.addByPrefix('enter', 'Joshua Portrait Enter', 24, false);
		portraitJosh.updateHitbox();
		portraitJosh.scrollFactor.set();
		add(portraitJosh);
		portraitJosh.visible = false;
		
		
		
		portraitSock = new FlxSprite(131, 203);
		portraitSock.frames = FlxAtlasFrames.fromSparrow('assets/images/portraits/luckyPort.png', 'assets/images/portraits/luckyPort.xml');
		portraitSock.animation.addByPrefix('enter', 'Lucky Portrait Enter', 24, false);
		portraitSock.updateHitbox();
		portraitSock.scrollFactor.set();
		add(portraitSock);
		portraitSock.visible = false;
		
		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/bfPortrait.png', 'assets/images/weeb/bfPortrait.xml');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		box = new FlxSprite(-20, 45);

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-pixel.png',
					'assets/images/weeb/pixelUI/dialogueBox-pixel.xml');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
				isPixel = 'yes';
			case 'roses':
				FlxG.sound.play('assets/sounds/ANGRY_TEXT_BOX' + TitleState.soundExt);

				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-senpaiMad.png',
					'assets/images/weeb/pixelUI/dialogueBox-senpaiMad.xml');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);
				isPixel = 'yes';

			case 'thorns':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic('assets/images/weeb/spiritFaceForward.png');
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
				isPixel = 'yes';
			case 'ridge' | 'vidya' | 'lockers' | 'void' | 'colors' | 'test':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/speech_bubble_talking.png', 'assets/images/speech_bubble_talking.xml');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, false);
				box.setPosition(0, (FlxG.height - box.height + 45));
				isPixel = 'no';
		}
		trace('Dia Time');
		box.animation.play('normalOpen');
		if (isPixel == 'yes')
		{
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		}
		box.updateHitbox();
		add(box);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic('assets/images/weeb/pixelUI/hand_textbox.png');
		add(handSelect);
		if (isPixel == 'yes')
		{
			box.screenCenter(X);
		}
		
		portraitLeft.screenCenter(X);

		if (!talkingRight && isPixel == 'no')
		{
			box.flipX = true;
		}
		
		if (talkingRight && isPixel == 'no')
		{
			box.flipX = false;
		}
		
		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		switch(isPixel)
		{
			case 'yes':
				dropText.font = 'Pixel Arial 11 Bold';
				dropText.color = 0xFFD89494;
			case 'no':
				dropText.font = 'TimKid';
				dropText.color = 0xFF000000;
		}
		
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		switch(isPixel)
		{
			case 'yes':
				swagDialogue.font = 'Pixel Arial 11 Bold';
				swagDialogue.color = 0xFFD89494;
			case 'no':
				swagDialogue.font = 'TimKid';
				swagDialogue.color = 0xFF000000;
		}
		swagDialogue.sounds = [FlxG.sound.load('assets/sounds/pixelText' + TitleState.soundExt, 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		this.dialogueList = dialogueList;
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY)
		{
			remove(dialogue);

			FlxG.sound.play('assets/sounds/clickText' + TitleState.soundExt, 0.8);

			if (dialogueList[1] == null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'ridge' || PlayState.SONG.song.toLowerCase() == 'vidya' || PlayState.SONG.song.toLowerCase() == 'lockers' || PlayState.SONG.song.toLowerCase() == 'void')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/pixelText' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitHead.visible = false;
				portraitBox.visible = false;
				portraitLock.visible = false;
				portraitJosh.visible = false;
				portraitSock.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				
			case 'head':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/head' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitBox.visible = false;
				portraitLock.visible = false;
				portraitJosh.visible = false;
				portraitSock.visible = false;
				if (!portraitHead.visible)
				{
					portraitHead.visible = true;
				}
				portraitHead.animation.play('enter');
			case 'headUnpleased':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/head_alt' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitBox.visible = false;
				portraitLock.visible = false;
				portraitSock.visible = false;
				portraitJosh.visible = false;
				if (!portraitHead.visible)
				{
					portraitHead.visible = true;
				}
				portraitHead.animation.play('enterAlt');
			case 'lucky':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/lucky' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitHead.visible = false;
				portraitBox.visible = false;
				portraitLock.visible = false;
				portraitLeft.visible = false;
				portraitJosh.visible = false;
				if (!portraitSock.visible)
				{
					portraitSock.visible = true;
					portraitSock.animation.play('enter');
				}
			case 'locky':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/locky' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitHead.visible = false;
				portraitBox.visible = false;
				portraitLeft.visible = false;
				portraitSock.visible = false;
				portraitJosh.visible = false;
				if (!portraitLock.visible)
				{
					portraitLock.visible = true;
				}
				portraitLock.animation.play('enter');
			case 'lockyPhased':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/locky_alt' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitHead.visible = false;
				portraitBox.visible = false;
				portraitSock.visible = false;
				portraitJosh.visible = false;
				if (!portraitLock.visible)
				{
					portraitLock.visible = true;
				}
				portraitLock.animation.play('enterAlt');
			case 'black':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/box' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitHead.visible = false;
				portraitLeft.visible = false;
				portraitLock.visible = false;
				portraitSock.visible = false;
				portraitJosh.visible = false;
				if (!portraitBox.visible)
				{
					portraitBox.visible = true;
					portraitBox.animation.play('enter');
				}
			case 'joshua':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/dialouge/joshua' + TitleState.soundExt, 0.6)];
				portraitRight.visible = false;
				portraitHead.visible = false;
				portraitLock.visible = false;
				portraitLeft.visible = false;
				portraitSock.visible = false;
				if (!portraitJosh.visible)
				{
					portraitJosh.visible = true;
					portraitJosh.animation.play('enter');
				}
			case 'bf':
				swagDialogue.sounds = [FlxG.sound.load('assets/sounds/pixelText' + TitleState.soundExt, 0.6)];
				portraitLeft.visible = false;
				portraitHead.visible = false;
				portraitLock.visible = false;
				portraitBox.visible = false;
				portraitSock.visible = false;
				portraitJosh.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
