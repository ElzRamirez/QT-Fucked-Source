import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Json;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

typedef AchievementFile =
{
	var unlocksAfter:String;
	var icon:String;
	var name:String;
	var description:String;
	var hidden:Bool;
	var customGoal:Bool;
}

class Achievements {
	public static var achievementShits:Array<Dynamic> = [//Name, Description, Achievement save tag, Unlocks after, Hidden achievement
		//Set unlock after to "null" if it doesnt unlock after a week!!
		["Freaky on a Friday Night",			"Play on a Friday... Night.",											'friday_night_play',		null, 			true],
		["Do you need help?",					"Beat Tutorial on Very Fucked.",										'tutorial_fucked',			null, 			false],
		["You r really sick...",				"Complete QT week on Fucked Difficulty.",								'qtweek_fucked',			null, 			false],
		["IMPOSSIBLE!!!",						"Beat Fuckedmination on Very Fucked.",									'fuckedmination_beat',		null, 			false],
		["Get a life, freaky!",					"Beat Fuckedmination on Fuck You. (Please, get a life bro)",			'fuckedmination_old',		null, 			false],
		["See you next time...",				"Beat Cessation.",														'cessation_beat',			null, 			false],
		["Try VS zRamirez man :)",				"Beat Bad Battle. (Please, try VS zRamírez)",							'badbattle_beat',			null, 			false],
		["Alertastic!",							"Beat Alertmination from the legacy modpack.",							'alert_beat',				null, 			true],
		["Master of the Style",					"Beat Censory SuperDrip on any difficulty from the legacy modpack.",	'drip_beat',				null, 			true],
		["EXTREME LIMITS!",						"Beat Fuckedmination Corrupted from the legacy modpack.",				'fuckedcorrupted_beat',		null, 			true],
		["WHAT ARE YOU DOING EVITO?!",			"Beat Fuckedmination VIP... (You Really Sick Man!).",					'fuckedvip_beat',			null, 			true],
		["WHAT ARE YOU DOING EDU?!",			"Beat Fuckedmination Duet VIP... (WHAT THE FUCK?!).",					'fuckedduovip_beat',		null, 			true],
		["Inhuman",								"Went into the depths of Freeplay...",									'freeplay_depths',			null, 			true],
		["Playing with fire!",					"Try to taunt over 30 times or more in Fuckedmination and win.",		'taunter_master',			null, 			false],
		["What a Funkin' Disaster!",			"Complete a Song with a rating lower than 20%.",						'ur_bad',					null, 			false],
		["Perfectionist",						"Complete a Song with a rating of 100%.",								'ur_good',					null,			false],
		["What is this doing here?",			"Download and Complete the Redacted Restored modpack.",					'long_time',				null,			true],
		//así es amigo mio, esto lo agregue a ultimo momento, por eso esta hasta abajo del todo, y sabes la puta paja que me da editar el puto png por que es una puta mierda este puto sistema de logros, prefiero al 100% el sistema de la psych 0.6 en adelante hjklñZSDFhjiklñszxdvhjiklñzxcvhjikolñdf
		["Alertastic but Classic?",				"Beat Alertmination Classic from the legacy modpack.",					'alertclassic_beat',		null, 			true],
		["Baby steps",							"Complete QT Duo week on Fucked Difficulty from the legacy modpack.",	'qtduo_week',				null, 			true],
		["Conformation",						"Beat Fuckedmination Duet from the legacy modpack.",					'fuckedmination_duo_beat',	null, 			true],
		["You r perfection",					"Beat Cessation Duet from the legacy modpack.",							'cessation_duo_beat',		null, 			true]
		//Me pregunto quien sería el jodidamente enfermo que llegue a conseguir estos logros
	];

	public static var achievementsStuff:Array<Dynamic> = [ 
		//Gets filled when loading achievements
	];

	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();
	public static var loadedAchievements:Map<String, AchievementFile> = new Map<String, AchievementFile>();

	public static var henchmenDeath:Int = 0;
	public static var sawbladeDeath:Int = 0;
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name)) {
			return achievementsMap.get(name);
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		achievementsStuff = [];
		achievementsStuff = achievementShits;

		#if MODS_ALLOWED
		//reloadAchievements(); //custom achievements do not work. will add once it doesn't do the duplication bug -bb
		#end

		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
			if(FlxG.save.data.achievementsUnlocked != null) {
				FlxG.log.add("Trying to load stuff");
				var savedStuff:Array<String> = FlxG.save.data.achievementsUnlocked;
				for (i in 0...savedStuff.length) {
					achievementsMap.set(savedStuff[i], true);
				}
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
			if(sawbladeDeath == 0 && FlxG.save.data.sawbladeDeath != null){
				sawbladeDeath = FlxG.save.data.sawbladeDeath;
			}
		}

		// You might be asking "Why didn't you just fucking load it directly dumbass??"
		// Well, Mr. Smartass, consider that this class was made for Mind Games Mod's demo,
		// i'm obviously going to change the "Psyche" achievement's objective so that you have to complete the entire week
		// with no misses instead of just Psychic once the full release is out. So, for not having the rest of your achievements lost on
		// the full release, we only save the achievements' tag names instead. This also makes me able to rename
		// achievements later as long as the tag names aren't changed of course.

		// Edit: Oh yeah, just thought that this also makes me able to change the achievements orders easier later if i want to.
		// So yeah, if you didn't thought about that i'm smarter than you, i think

		// buffoon

		// EDIT 2: Uhh this is weird, this message was written for MInd Games, so it doesn't apply logically for Psych Engine LOL
	}

	public static function reloadAchievements() {	//Achievements in game are hardcoded, no need to make a folder for them
		loadedAchievements.clear();

		#if MODS_ALLOWED //Based on WeekData.hx
		var disabledMods:Array<String> = [];
		var modsListPath:String = 'modsList.txt';
		var directories:Array<String> = [Paths.mods()];
		if(FileSystem.exists(modsListPath))
		{
			var stuff:Array<String> = CoolUtil.coolTextFile(modsListPath);
			for (i in 0...stuff.length)
			{
				var splitName:Array<String> = stuff[i].trim().split('|');
				if(splitName[1] == '0') // Disable mod
				{
					disabledMods.push(splitName[0]);
				}
				else // Sort mod loading order based on modsList.txt file
				{
					var path = haxe.io.Path.join([Paths.mods(), splitName[0]]);
					//trace('trying to push: ' + splitName[0]);
					if (sys.FileSystem.isDirectory(path) && !Paths.ignoreModFolders.contains(splitName[0]) && !disabledMods.contains(splitName[0]) && !directories.contains(path + '/'))
					{
						directories.push(path + '/');
						//trace('pushed Directory: ' + splitName[0]);
					}
				}
			}
		}

		var modsDirectories:Array<String> = Paths.getModDirectories();
		for (folder in modsDirectories)
		{
			var pathThing:String = haxe.io.Path.join([Paths.mods(), folder]) + '/';
			if (!disabledMods.contains(folder) && !directories.contains(pathThing))
			{
				directories.push(pathThing);
				//trace('pushed Directory: ' + folder);
			}
		}

		for (i in 0...directories.length) {
			var directory:String = directories[i] + 'achievements/';

			//trace(directory);
			if (FileSystem.exists(directory)) {

				var listOfAchievements:Array<String> = CoolUtil.coolTextFile(directory + 'achievementList.txt');

				for (achievement in listOfAchievements) {
					var path:String = directory + achievement + '.json';

					if (FileSystem.exists(path) && !loadedAchievements.exists(achievement) && achievement != PlayState.othersCodeName) {
						loadedAchievements.set(achievement, getAchievementInfo(path));
					}

					//trace(path);
				}

				for (file in FileSystem.readDirectory(directory)) {
					var path = haxe.io.Path.join([directory, file]);
					
					var cutName:String = file.substr(0, file.length - 5);
					if (!FileSystem.isDirectory(path) && file.endsWith('.json') && !loadedAchievements.exists(cutName) && cutName != PlayState.othersCodeName) {
						loadedAchievements.set(cutName, getAchievementInfo(path));
					}

					//trace(file);
				}
			}
		}

		for (json in loadedAchievements) {
			//trace(json);
			achievementsStuff.push([json.name, json.description, json.icon, json.unlocksAfter, json.hidden]);
		}
		#end
	}

	private static function getAchievementInfo(path:String):AchievementFile {
		var rawJson:String = null;
		#if MODS_ALLOWED
		if (FileSystem.exists(path)) {
			rawJson = File.getContent(path);
		}
		#else
		if(OpenFlAssets.exists(path)) {
			rawJson = Assets.getText(path);
		}
		#end

		if(rawJson != null && rawJson.length > 0) {
			return cast Json.parse(rawJson);
		}
		return null;
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			var imagePath:FlxGraphic = Paths.image('achievementgrid');
			var isModIcon:Bool = false;

			if (Achievements.loadedAchievements.exists(tag)) {
				isModIcon = true;
				imagePath = Paths.image(Achievements.loadedAchievements.get(tag).icon);
			}

			var index:Int = Achievements.getAchievementIndex(tag);
			if (isModIcon) index = 0;

			trace(imagePath);

			loadGraphic(imagePath, true, 150, 150);
			animation.add('icon', [index], 0, false, false);
			animation.play('icon');
		} else {
			loadGraphic(Paths.image('lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achieveName:String = Achievements.achievementsStuff[id][0];
		var text:String = Achievements.achievementsStuff[id][1];

		if(Achievements.loadedAchievements.exists(name)) {
			id = 0;
			achieveName = Achievements.loadedAchievements.get(name).name;
			text = Achievements.loadedAchievements.get(name).description;
		}

		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var imagePath = Paths.image('achievementgrid');
		var modsImage = null;
		var isModIcon:Bool = false;

		//fucking hell bro
		/*if (Achievements.loadedAchievements.exists(name)) {
			isModIcon = true;
			modsImage = Paths.image(Achievements.loadedAchievements.get(name).icon);
		}*/

		var index:Int = Achievements.getAchievementIndex(name);
		if (isModIcon) index = 0;

		//trace(imagePath);
		//trace(modsImage);

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic((isModIcon ? modsImage : imagePath), true, 150, 150);
		achievementIcon.animation.add('icon', [index], 0, false, false);
		achievementIcon.animation.play('icon');
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, achieveName, 16);
		achievementName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, text, 16);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}