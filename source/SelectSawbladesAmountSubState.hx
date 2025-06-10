package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import PlayState;

class SelectSawbladesAmountSubState extends MusicBeatSubstate
{
    var amountOptions:Array<Int> = [8, 4, 0];
    var curSelected:Int = 0;

    var titleText:FlxText;
    var optionTexts:Array<FlxText> = [];

    var blackBG:FlxSprite;

    public var canControl:Bool = false;
    public var isClosing:Bool = false;

    public function new()
    {
        super();

        blackBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackBG.alpha = 0;
        add(blackBG);

        FlxTween.tween(blackBG, {alpha: 0.6}, 0.25, {ease: FlxEase.circIn});

        titleText = new FlxText(0, 80, FlxG.width, "Sawblade Hits Limit:");
        titleText.setFormat(Paths.font("vcr.ttf"), 80, FlxColor.WHITE, CENTER);
        titleText.alpha = 0;
        add(titleText);
        FlxTween.tween(titleText, {alpha: 1}, 0.25, {ease: FlxEase.circIn});

        var spacing:Float = 300;
        var startX:Float = (FlxG.width / 2) - ((amountOptions.length - 1) * spacing / 2);

        for (i in 0...amountOptions.length)
        {
            var optionText = new FlxText(startX + i * spacing, FlxG.height / 2, 0, Std.string(amountOptions[i]));
            optionText.setFormat(Paths.font("vcr.ttf"), 120, FlxColor.WHITE, CENTER);
            optionText.alpha = 0;
            optionTexts.push(optionText);
            add(optionText);

            FlxTween.tween(optionText, {alpha: 1}, 0.25, {ease: FlxEase.circIn});
        }

        updateVisualSelection();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (canControl && !isClosing)
        {
            if (controls.UI_RIGHT_P)
            {
                curSelected = (curSelected + 1) % amountOptions.length;
                FlxG.sound.play(Paths.sound('scrollMenu'));
                updateVisualSelection();
            }
            else if (controls.UI_LEFT_P)
            {
                curSelected = (curSelected - 1 + amountOptions.length) % amountOptions.length;
                FlxG.sound.play(Paths.sound('scrollMenu'));
                updateVisualSelection();
            }

            if (controls.ACCEPT)
            {
                FlxG.sound.play(Paths.sound('confirmMenu'));
                PlayState.maxSawbladeHits = amountOptions[curSelected];
                doFadeOut(true);
            }

            if (controls.BACK)
            {
                FlxG.sound.play(Paths.sound('cancelMenu'));
                doFadeOut(false);
            }
        }
		else
			canControl = true;
    }

    function updateVisualSelection()
    {
        for (i in 0...optionTexts.length)
        {
            if (i == curSelected)
            {
                optionTexts[i].alpha = 1;
            }
            else
            {
                optionTexts[i].alpha = 0.5;
            }
        }
    }

    function doFadeOut(goToPlayState:Bool)
    {
        isClosing = true;
        canControl = false;

        FlxTween.tween(blackBG, {alpha: 0}, 0.25, {
            ease: FlxEase.circOut,
            onComplete: function(twn:FlxTween)
            {
                if (goToPlayState)
                {
                    LoadingState.loadAndSwitchState(new PlayState());
                }
                else
                {
                    close();
                }
            }
        });

        FlxTween.tween(titleText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        for (optionText in optionTexts)
        {
            FlxTween.tween(optionText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
        }
    }
}