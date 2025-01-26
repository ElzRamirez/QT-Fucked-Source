--Stage by zRamirez
function onCreate()

	makeLuaSprite('stageback', 'stage-redacted/back', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'stage-redacted/shader', -200, 0);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', true);
    
	close(true);
end