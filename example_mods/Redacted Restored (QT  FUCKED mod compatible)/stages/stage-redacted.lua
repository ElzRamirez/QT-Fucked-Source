--Stage hecha por zRamirez
function onCreate()

	makeLuaSprite('stageback', 'stage-redacted/back', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'stage-redacted/shader', -200, 0);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', true);

	makeAnimatedLuaSprite('qt_tv01', 'stage-redacted/tv-single', 670, 860)
    addAnimationByPrefix('qt_tv01', 'idle', 'TVSINGLE-IDLE', 24, true)
    scaleObject('qt_tv01', 1.4, 1.4)
    setLuaSpriteScrollFactor('qt_tv01', 1.0, 1.0)
    addLuaSprite('qt_tv01', false)
    objectPlayAnimation('qt_tv01', 'idle')
    
	close(true);
end