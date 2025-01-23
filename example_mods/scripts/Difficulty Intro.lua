--script modified by zRamirez
--easy script configs
DifIntroTextSize = 25	--Size of the text for the Difficulty thing.
DifIntroSubTextSize = 28 --size of the text for the Dif Name.
DifIntroTagColor = '8300c3'	--Color of the tag at the end of the dif box.
DifIntroTagWidth = 15	--Width of the dif box's tag thingy.
--easy script configs

--actual script
function onCreate()
	--the tag at the end of the dif box
	makeLuaSprite('JukeDifBoxTag', 'empty', -305-DifIntroTagWidth, 125)
	makeGraphic('JukeDifBoxTag', 300+DifIntroTagWidth, 100, '3EFFE4')
	setObjectCamera('JukeDifBoxTag', 'other')
	addLuaSprite('JukeDifBoxTag', true)

	--the dif box
	makeLuaSprite('JukeDifBox', 'empty', -305-DifIntroTagWidth, 125)
	makeGraphic('JukeDifBox', 300, 100, '000000')
	setObjectCamera('JukeDifBox', 'other')
	addLuaSprite('JukeDifBox', true)
	
	--the text for the "Difficulty" bit
	makeLuaText('JukeDifBoxText', 'Difficulty is:', 300, -305-DifIntroTagWidth, 140)
	setTextAlignment('JukeDifBoxText', 'left')
	setObjectCamera('JukeDifBoxText', 'other')
	setTextSize('JukeDifBoxText', DifIntroTextSize)
	addLuaText('JukeDifBoxText')
	
	--text for the difficulty name
        currentDifficulty = getProperty('storyDifficultyText');
	makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
	setTextAlignment('JukeDifBoxSubText', 'left')
	setObjectCamera('JukeDifBoxSubText', 'other')
	setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
	addLuaText('JukeDifBoxSubText')
          if songName == 'Fuckedmination' then -- for Termination
             if difficulty ~= 0 then
                 currentDifficulty = getProperty('Very Fucked');
	         makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
	         setTextAlignment('JukeDifBoxSubText', 'left')
	         setObjectCamera('JukeDifBoxSubText', 'other')
	         setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
	         addLuaText('JukeDifBoxSubText')
             end
             if difficulty ~= 1 then
                 currentDifficulty = getProperty('Fuck You!');
	         makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
	         setTextAlignment('JukeDifBoxSubText', 'left')
	         setObjectCamera('JukeDifBoxSubText', 'other')
	         setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
	         addLuaText('JukeDifBoxSubText')
             end
          end
		  if songName == 'Fuckinfree' then -- for Cessation
			if difficulty ~= 0 then
				currentDifficulty = getProperty('Fucked');
			makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
			setTextAlignment('JukeDifBoxSubText', 'left')
			setObjectCamera('JukeDifBoxSubText', 'other')
			setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
			addLuaText('JukeDifBoxSubText')
			end
		 end
		 if songName == 'Fuckedless' then -- for Cessation
			if difficulty ~= 0 then
				currentDifficulty = getProperty('Fucked');
			makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
			setTextAlignment('JukeDifBoxSubText', 'left')
			setObjectCamera('JukeDifBoxSubText', 'other')
			setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
			addLuaText('JukeDifBoxSubText')
			end
		 end
		 if songName == 'Censory-Fuckedload' then -- for Cessation
			if difficulty ~= 0 then
				currentDifficulty = getProperty('Fucked');
			makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
			setTextAlignment('JukeDifBoxSubText', 'left')
			setObjectCamera('JukeDifBoxSubText', 'other')
			setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
			addLuaText('JukeDifBoxSubText')
			end
		 end
          if songName == 'Cessation' then -- for Cessation
             if difficulty ~= 0 then
                 currentDifficulty = getProperty('Future?...');
	         makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
	         setTextAlignment('JukeDifBoxSubText', 'left')
	         setObjectCamera('JukeDifBoxSubText', 'other')
	         setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
	         addLuaText('JukeDifBoxSubText')
             end
          end
		  if songName == 'Interlope' then -- for Interlope
			if difficulty ~= 0 then
				currentDifficulty = getProperty('???');
			makeLuaText('JukeDifBoxSubText', currentDifficulty, 300, -305-DifIntroTagWidth, 170)
			setTextAlignment('JukeDifBoxSubText', 'left')
			setObjectCamera('JukeDifBoxSubText', 'other')
			setTextSize('JukeDifBoxSubText', DifIntroSubTextSize)
			addLuaText('JukeDifBoxSubText')
			end
		 end
end

--motion functions
function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('DifMoveInOne', 'JukeDifBoxTag', 0, 1, 'DifCircInOut')
	doTweenX('DifMoveInTwo', 'JukeDifBox', 0, 1, 'DifCircInOut')
	doTweenX('DifMoveInThree', 'JukeDifBoxText', 0, 1, 'DifCircInOut')
	doTweenX('DifMoveInFour', 'JukeDifBoxSubText', 0, 1, 'DifCircInOut')
	
	runTimer('JukeDifBoxWait', 3, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == 'JukeDifBoxWait' then
		doTweenX('DifMoveOutOne', 'JukeDifBoxTag', -450, 1.5, 'DifCircInOut')
		doTweenX('DifMoveOutTwo', 'JukeDifBox', -450, 1.5, 'DifCircInOut')
		doTweenX('DifMoveOutThree', 'JukeDifBoxText', -450, 1.5, 'DifCircInOut')
		doTweenX('DifMoveOutFour', 'JukeDifBoxSubText', -450, 1.5, 'DifCircInOut')
	end
end