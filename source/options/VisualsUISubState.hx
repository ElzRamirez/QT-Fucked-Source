package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import Note;
import StrumNote;
import NoteSplash;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public var splashes:FlxTypedGroup<NoteSplash>;
	public var notes:FlxTypedGroup<StrumNote>;
	var notesTween:Array<FlxTween> = [];
	var noteY:Float = 90;
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		// for note skins
		notes = new FlxTypedGroup<StrumNote>();
		splashes = new FlxTypedGroup<NoteSplash>();
		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = new StrumNote(370 + (560 / Note.colArray.length) * i, -200, i, 0);
			changeNoteSkin(note);
			notes.add(note);

			var splash:NoteSplash = new NoteSplash(0, 0, 0);
			splash.ID = i;
			splash.kill();
			splashes.add(splash);
		}

		var option:Option = new Option('Note Skins: ',
			"Choose what texture you want to be used in on the Notes.",
			'noteSkin',
			'string',
			'Vanilla',
			['Vanilla', 'Future', 'Chip', 'Bar', 'Diamond', 'Square', 'DoritosPizzerola']);
		addOption(option);
		option.onChange = onChangeNoteSkin;

		var option:Option = new Option('Note Splashes: ',
			"Choose what texture you want to be used in the Note Splashes.",
			'splashSkin',
			'string',
			'Lightning',
			['Vanilla', 'Psych', 'Diamond', 'Electric', 'Sparkles', 'Lightning']);
		addOption(option);
		option.onChange = onChangeSplashSkin;

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Hurt note transparency',
			"Allows you to customise how opaque the hurt notes are to allow you to read charts easier.",
			'hurtNoteAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Move Camera when Sing',
			"If unchecked, the camera won't move when characters sing.",
			'moveCameraWhenSing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end

		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			'Breakfast',
			['None', 'Breakfast', 'zRamirez']);
		addOption(option);
		option.onChange = onChangePauseMusic;

		super();
		add(notes);
		add(splashes);
	}

	var notesShown:Bool = false;
	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);

		switch(curOption.variable)
		{
			case 'noteSkin', 'splashSkin':
				if(!notesShown)
				{
					for (note in notes.members)
					{
						FlxTween.cancelTweensOf(note);
						FlxTween.tween(note, {y: noteY}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
					}
				}
				notesShown = true;
				if (curOption.variable.startsWith('splash') && Math.abs(notes.members[0].y - noteY) < 25) playNoteSplashes();

			default:
				if(notesShown) 
				{
					for (note in notes.members)
					{
						FlxTween.cancelTweensOf(note);
						FlxTween.tween(note, {y: -200}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
					}
				}
				notesShown = false;

		}
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic == 'Breakfast' ? "breakfast-pixel" : (ClientPrefs.pauseMusic == 'zRamirez' ? "ramirez-week-pause" : ClientPrefs.pauseMusic))));

		changedMusic = true;
	}

	function onChangeNoteSkin()
	{
		notes.forEachAlive(function(note:StrumNote) {
			changeNoteSkin(note);
			note.centerOffsets();
			note.centerOrigin();
		});
	}

	function changeNoteSkin(note:StrumNote)
	{
		var skin:String = 'noteShit/' + ClientPrefs.noteSkin;
		var customSkin:String = ClientPrefs.noteSkin;
		if(Paths.fileExists('images/$customSkin.png', IMAGE)) skin = customSkin;

		note.texture = skin; //Load texture and anims
		note.reloadNote();
		note.playAnim('static');
	}

	function onChangeSplashSkin()
		playNoteSplashes();

	function playNoteSplashes()
	{
		splashes.forEach(function(splash:NoteSplash)
		{
			final hue:Float = ClientPrefs.arrowHSV[splash.ID][0] / 360;
			final sat:Float = ClientPrefs.arrowHSV[splash.ID][1] / 100;
			final brt:Float = ClientPrefs.arrowHSV[splash.ID][2] / 100;
			splash.revive();
			splash.setupNoteSplash(notes.members[splash.ID].x, notes.members[splash.ID].y, splash.ID, 'noteSplashShit/' + ClientPrefs.splashSkin, hue, sat, brt);
		});
	}

	function onChangeSplashAlpha()
		playNoteSplashes();

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('qtMenu'));
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end
}