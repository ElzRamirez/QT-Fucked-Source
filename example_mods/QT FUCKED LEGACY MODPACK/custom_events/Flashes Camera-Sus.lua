function onEvent(n,v1,v2)
	if n == 'Flashes Camera-Sus' then
		if getPropertyFromClass('ClientPrefs', 'flashing') == true then
			makeLuaSprite('flash', '', 0, 0);
			makeGraphic('flash',1280,720,'0065d8')
			setObjectCamera('flash', 'camGame')
			addLuaSprite('flash', true);
			setLuaSpriteScrollFactor('flash',0,0)
			setProperty('flash.scale.x',3)
			setProperty('flash.scale.y',3)
			setProperty('flash.alpha',0)
			setProperty('flash.alpha',0.5)
			doTweenAlpha('flTw','flash',0,0.5,'linear')
		end
	end
end