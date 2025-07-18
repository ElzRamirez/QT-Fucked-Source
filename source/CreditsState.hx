package;

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
import flixel.tweens.FlxTween;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		//trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		};
		var folder = "";
			var creditsFile:String = Paths.mods('data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		#end
		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['QT FUCKED DIFFICULTY DEVS'],
			['zRamirez',			'zramirez',			'Owner Dev, Musician, Artist, Charter and Fucking Loser',			'https://www.youtube.com/channel/UCPvBcpUxgtJpcJUZEiRPK_g',			'FFE800'],
			['DrkFon376',			'drkfon',			'Co-Owner Dev, Bugfix, New Title Screen Programer',					'https://www.youtube.com/channel/UCCVTns4b43V8Q5EON8xuSUQ',			'0A5DAF'],
			[''],
			[''],
			['QT FUCKED CONTRIBUTORS'],
			['Glowsoony',			'glow',				'Ported the Note Skin and Splash Skin System From vs zRamírez, Help to fixed some bugs',	'https://www.youtube.com/channel/UCQQo4VDFWv_LX6tHzmBu8kA',	'66AFEC'],
			['Imanol',				'ima',				'Beta Tester',														'https://www.youtube.com/channel/UCs9dXV0B7uKACyyW9PBFYCA',			'583627'],
			['Edu_YT',				'edu',				'Help with bugs, Beta Tester',										'https://youtube.com/@edu_yt123?si=Iot1QHJIORSDvKb9',				'1ccc00'],
			['Hugo',				'hugo4ever',		'Creator of the inst remixes from Censory and Termination',			'https://youtube.com/@hugo4ever12?si=NfgX4zY5Aybc7fYO',				'FFFF00'],
			[''],
			[''],
			['Extra Mod Credits'],
			['Ara',						'ara',				'Character Designer and She gave us permission to use her character for the mod (Thanks Sweetie :3)',					'https://discord.gg/g2mCEc9rH5',									'A02EFF'],
			['Zero-Black',				'0',				'Designer of the life icons from vs zRamírez',																						'https://youtube.com/@zeroblackyu?si=Buw96RA6buCwoP2w',				'EF7216'],
			['Iandee',				'iandee',			'Creator of the Original Design of the BF and GF Sprites from the VS Impostor Dialogues and Speaker Sprite used from Ara',		'https://www.youtube.com/channel/UCnoOhpnxHWtayIJUCutfP7w',				'B0B0B0'],
			['DestrioSZ',			'destriosz',		'Artist of the GF base Sprites used from Ara Sprites',																			'https://gamebanana.com/members/2080836',								'B0B0B0'],
			['MtH',					'mth',				'Creator of the Original Voices from Test song',																				'https://x.com/emmnyaa',												'B0B0B0'],
			['AnbyFox',				'snowie',			'Termination Corrupted mod original, Creator from corrupted assets and Creator from borderless alert skin',						'https://www.youtube.com/channel/UC1_5RkgBEwR8aTaA1gFNg1Q/featured',	'B0B0B0'],
			[''],
			[''],
			['Discord Server'],
			['zRamirez Discord Server',		'discord',	'zRamírez Official Discord Server, There are Announcements about the Mod, Spoilers and Many Other Things! (Spanish and English Supported)',  	   'https://discord.gg/g2mCEc9rH5',			'4C5CE4'],
			[''],
			[''],
			['QT Mod Team'],
			['Hazard24',			'hazard',			'Programming, Music, Charting, Animation, SFX',			'https://twitter.com/Hazard248',		'FFD402'],
			['CountNightshade',		'nightshade',		'Art, Character Design',								'https://twitter.com/CountNightshade',	'9930BB'],
			[''],
			[''],
			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',						'https://twitter.com/Shadow_Mario_',	'444444'],
			['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',					'https://twitter.com/river_oaken',		'C30085'],
			['bb-panzu',			'bb-panzu',			'Additional Programmer of Psych Engine',				'https://twitter.com/bbsub3',			'389A58'],
			[''],
			['Engine Contributors'],
			['shubs',				'shubs',			'New Input System Programmer',							'https://twitter.com/yoshubs',			'4494E6'],
			['SqirraRNG',			'gedehari',			'Chart Editor\'s Sound Waveform base',					'https://twitter.com/gedehari',			'FF9300'],
			['iFlicky',				'iflicky',			'Delay/Combo Menu Song Composer\nand Dialogue Sounds',	'https://twitter.com/flicky_i',			'C549DB'],
			['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',							'https://twitter.com/polybiusproxy',	'FFEAA6'],
			['Keoiki',				'keoiki',			'Note Splash Animations',								'https://twitter.com/Keoiki_',			'FFFFFF'],
			['Smokey',				'smokey',			'Spritemap Texture Support',							'https://twitter.com/Smokey_5_',		'0033CC'],
			[''],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",					'https://twitter.com/ninja_muffin99',	'F73838'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",						'https://twitter.com/PhantomArcade3K',	'FFBB1B'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",						'https://twitter.com/evilsk8r',			'53E52C'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",						'https://twitter.com/kawaisprite',		'6475F3']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}