package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import PlayState;

class SelectSawbladesAmountSubState extends MusicBeatSubstate
{
    var amountOptions:Array<Int> = [8, 4, 0];
    var curSelected:Int = 0;

    var titleText:FlxText;
    var optionTexts:Array<FlxText> = [];
    var sawbladeSprites:Array<FlxSprite> = [];
    var arrowSprite:FlxSprite;

    var blackBG:FlxSprite;

    public var canControl:Bool = false;
    public var isClosing:Bool = false;
    public var isFromPauseMenu:Bool = false;
    public static var sawbladesAmountModified:Bool = false;

    var state:String = "select";
    var confirmSelected:Int = 0;
    var confirmText:FlxText;
    var confirmOptions:Array<FlxText> = [];

    public function new(?defaultValue:Int = 8, ?fromPauseMenu:Bool = false)
    {
        super();

        isFromPauseMenu = fromPauseMenu;
        curSelected = amountOptions.indexOf(defaultValue);

        blackBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackBG.alpha = isFromPauseMenu ? 0.75 : 0;
        add(blackBG);

        titleText = new FlxText(0, 80, FlxG.width, "Sawblade Hits Limit:");
        titleText.setFormat(Paths.font("vcr.ttf"), 80, FlxColor.WHITE, CENTER);
        titleText.alpha = isFromPauseMenu ? 1 : 0;
        add(titleText);

        var spacing:Float = 300;
        var startX:Float = (FlxG.width / 2) - ((amountOptions.length - 1) * spacing / 2);

        for (i in 0...amountOptions.length)
        {
            var optionText = new FlxText(startX + i * spacing, 480, 0, Std.string(amountOptions[i]));
            optionText.setFormat(Paths.font("vcr.ttf"), 120, (amountOptions[i] == 0 && (FreeplayState.isSongLockedIn0sawblades && !PlayState.chartingMode)) ? FlxColor.RED : FlxColor.WHITE, CENTER);
            optionText.alpha = 0;
            optionTexts.push(optionText);
            add(optionText);

            var sawbladeImage:String = 'Sawblade_${amountOptions[i]}_Hits';
            var sawbladeSprite = new FlxSprite(startX - 35 + i * spacing, 280);
            sawbladeSprite.loadGraphic(Paths.image(sawbladeImage));
            sawbladeSprite.updateHitbox();
            sawbladeSprite.antialiasing = ClientPrefs.globalAntialiasing;
            sawbladeSprite.alpha = 0;
            sawbladeSprites.push(sawbladeSprite);
            add(sawbladeSprite);
        }

        arrowSprite = new FlxSprite();
        arrowSprite.loadGraphic(Paths.image('ArrowDownSelection'));
        arrowSprite.setGraphicSize(Std.int(arrowSprite.width * 0.4));
        arrowSprite.updateHitbox();
        arrowSprite.antialiasing = ClientPrefs.globalAntialiasing;
        arrowSprite.alpha = isFromPauseMenu ? 1 : 0;
        add(arrowSprite);

        confirmText = new FlxText(0, 130, FlxG.width, "This will restart the current\nsong progress.\n\nAre you sure about that?");
        confirmText.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.WHITE, CENTER);
        confirmText.visible = false;
        add(confirmText);

        var confirmLabels = ["Yes", "No"];
        for (i in 0...confirmLabels.length)
        {
            var opt = new FlxText(400 + i * 300, 450, 0, confirmLabels[i]);
            opt.setFormat(Paths.font("vcr.ttf"), 100, FlxColor.WHITE, CENTER);
            opt.alpha = 0;
            confirmOptions.push(opt);
            add(opt);
        }

        if (!isFromPauseMenu)
        {
            FlxTween.tween(blackBG, {alpha: 0.6}, 0.25, {ease: FlxEase.circIn});
            FlxTween.tween(arrowSprite, {alpha: 1}, 0.25, {ease: FlxEase.circIn});

            for (i in 0...amountOptions.length)
            {
                FlxTween.tween(optionTexts[i], {alpha: (i == curSelected) ? 1 : 0.5}, 0.25, {ease: FlxEase.circIn});
                FlxTween.tween(sawbladeSprites[i], {alpha: (i == curSelected) ? 1 : 0.5}, 0.25, {ease: FlxEase.circIn});
            }
            
            FlxTween.tween(titleText, {alpha: 1}, 0.25, {ease: FlxEase.circIn,
                onComplete: function(twn:FlxTween)
                {
                    canControl = true;
                }
            });
        }
        else
        {
            new FlxTimer().start(0.25, function(tmr:FlxTimer)
			{
				canControl = true;
			});
        }

        updateVisualSelection();

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    }

    override function update(elapsed:Float)
    {
        if (isFromPauseMenu)
        {
            if (PauseSubState.pauseMusic.volume < 0.5)
		    	PauseSubState.pauseMusic.volume += 0.01 * elapsed;
        }

        if (canControl && !isClosing)
        {
            var rightP = controls.UI_RIGHT_P;
            var leftP = controls.UI_LEFT_P;
            var accepted = controls.ACCEPT;

            if (state == "select")
            {
                if (rightP)
                {
                    selectionChange(1);
                }
                else if (leftP)
                {
                    selectionChange(-1);
                }

                if (accepted)
                {
                    if (isFromPauseMenu)
                    {
                        state = "confirm";
                        FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                        confirmSelected = 1;
                        updateVisualState();
                    }
                    else
                    {
                        PlayState.maxSawbladeHits = amountOptions[curSelected];
                        sawbladesAmountModified = true;
                        doFadeOut(true);
                        FlxG.sound.music.volume = 0;
                        FreeplayState.destroyFreeplayVocals();
                    }
                }

                if (controls.BACK)
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    doFadeOut();
                }
            }
            else if (state == "confirm")
            {
                if (rightP)
                {
                    confirmSelected = (confirmSelected + 1) % 2;
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                    updateConfirmVisual();
                }
                else if (leftP)
                {
                    confirmSelected = (confirmSelected - 1 + 2) % 2;
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                    updateConfirmVisual();
                }

                if (accepted)
                {
                    if (confirmSelected == 0)
                    {
                        PlayState.maxSawbladeHits = amountOptions[curSelected];
                        sawbladesAmountModified = true;
                        PauseSubState.restartSong();
                    }
                    else
                    {
                        FlxG.sound.play(Paths.sound('cancelMenu'));
                        state = "select";
                        updateVisualState();
                    }
                }
            }
        }

        super.update(elapsed);
    }

    function updateVisualSelection()
    {
        for (i in 0...optionTexts.length)
        {
            optionTexts[i].alpha = (i == curSelected) ? 1 : 0.5;
            sawbladeSprites[i].alpha = (i == curSelected) ? 1 : 0.5;

            arrowSprite.x = sawbladeSprites[curSelected].x + (sawbladeSprites[curSelected].width / 2) - (arrowSprite.width / 2);
            arrowSprite.y = sawbladeSprites[curSelected].y - arrowSprite.height - 25;
        }
    }

    function selectionChange(change:Int)
    {
        if (FreeplayState.isSongLockedIn0sawblades && !PlayState.chartingMode)
        {
            FlxG.cameras.list[FlxG.cameras.list.length - 1].shake(0.0015, 0.25);
            FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
        }
        else
        {
            curSelected = (curSelected + change + amountOptions.length) % amountOptions.length;
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
            updateVisualSelection();
        }
    }

    function updateVisualState()
    {
        titleText.visible = (state == "select") ? true : false;

        for (i in 0...optionTexts.length)
        {
            optionTexts[i].visible = (state == "select");
            sawbladeSprites[i].visible = (state == "select");
        }

        arrowSprite.visible = (state == "select");

        confirmText.visible = (state == "confirm") ? true : false;
        for (opt in confirmOptions)
        {
            opt.visible = (state == "confirm");
        }

        if (state == "confirm")
        {
            updateConfirmVisual();
        }
    }

    function updateConfirmVisual()
    {
        for (i in 0...confirmOptions.length)
        {
            confirmOptions[i].alpha = (i == confirmSelected) ? 1 : 0.5;
        }
    }

    function doFadeOut(goToPlayState:Bool = false)
    {
        isClosing = true;
        canControl = false;

        FlxTween.tween(blackBG, {alpha: 0}, 0.25, {
            ease: FlxEase.circOut,
            onComplete: function(twn:FlxTween)
            {
                if (goToPlayState)
                {
                    LoadingState.loadAndSwitchState(new PlayState(), PlayState.isStoryMode ? true : false);
                }
                else
                {
                    if (PlayState.isStoryMode)
                    {
                        StoryMenuState.grpWeekText.members[StoryMenuState.curWeek].stopFlashing();
                        StoryMenuState.selectedWeek = false;
                        StoryMenuState.stopspamming = false;
                    }
                    else
                    {
                        if (!isFromPauseMenu)
                            PlayState.SONG = null;
                    }

                    close();
                }
            }
        });

        FlxTween.tween(titleText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        FlxTween.tween(arrowSprite, {alpha: 0}, 0.25, {ease: FlxEase.circOut});

        for (optionText in optionTexts)
        {
            FlxTween.tween(optionText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        }

        for (sawbladeSprite in sawbladeSprites)
        {
            FlxTween.tween(sawbladeSprite, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        }

        FlxTween.tween(confirmText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        for (opt in confirmOptions)
        {
            FlxTween.tween(opt, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        }
    }
}