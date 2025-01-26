--new dodge system Made By EDWHAK_KB
--Credit me if You use this

local dodgeTiming = 0.2
local dodgeCooldown = 0.030
local dodging = false
local canDodge = false
Damage = 0.4
instakill = false
local hits = 0 --maximum hits = 4
local beHit = true
local maxHits = 4
local limitHits = 4

function onEvent(name, v1, v2)
	if name == 'KB_Alerts' then
		if v1 == '1' then
			doWarning()
		end
		if v1 == '2' then
			doWarningDuo()
		end
		if v1 == '3' then
			doWarningTriple()
		end
		if v1 == '4' then
			doWarningQuadruple()
		end
		if v2 == 'yes' then
			setProperty('SawBlade1.alpha', 1)
			objectPlayAnimation('SawBlade1', 'Preparing', true);
		end
	end
	if name == 'KB_Attacks' then
		if v1 == '1' then
			SdoAttack()
			setProperty('SawBlade1.alpha', 0)
		end
		if v1 == '2' then
			SdoAttackDuo()
			setProperty('SawBlade1.alpha', 0)
		end
		if v1 == '3' then
			SdoAttackTriple()
			setProperty('SawBlade1.alpha', 0)
		end
		if v1 == '4' then
			SdoAttackQuadruple()
			setProperty('SawBlade1.alpha', 0)
		end
		if v2 == 'yes' then
			instakill = true
		end
		if v2 == 'no' then
			instakill = false
		end
	end
    if name == '1-DodgeSingle' then
        Sbeat0 = curBeat+1
		Sbeat1 = curBeat+2
		Sbeat2 = curBeat+3

		if v1 == 'true' then
			instakill = true
		end
    end
    if name == '2-DodgeDuo' then
		Dbeat0 = curBeat+1
		Dbeat1 = curBeat+2
		Dbeat2 = curBeat+3
        Dbeat3 = curBeat+4

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == '3-DodgeTriple' then
		Tbeat0 = curBeat+1
		Tbeat1 = curBeat+2
		Tbeat2 = curBeat+3
        Tbeat3 = curBeat+4
		Tbeat4 = curBeat+5
		Tbeat5 = curBeat+6
        Tbeat6 = curBeat+7

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == '4-DodgeQuadruple' then
		Qbeat0 = curBeat+1
		Qbeat1 = curBeat+2
		Qbeat2 = curBeat+3
        Qbeat3 = curBeat+4
		Qbeat4 = curBeat+5
		Qbeat5 = curBeat+6
        Qbeat6 = curBeat+7
        Qbeat7 = curBeat+8

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == '5-DodgeTripleFast' then
		TFbeat0 = curBeat+1
		TFbeat1 = curBeat+2
		TFbeat2 = curBeat+3
        TFbeat3 = curBeat+4
		TFbeat4 = curBeat+5

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == '6-DodgeQuadFast' then
		QFbeat0 = curBeat+1
		QFbeat1 = curBeat+2
		QFbeat2 = curBeat+3
        QFbeat3 = curBeat+4
		QFbeat4 = curBeat+5
        QFbeat5 = curBeat+6

		if v1 == 'true' then
			instakill = true
		end
	end
end

function onCreatePost()

    --SAWBLADE THING

	makeAnimatedLuaSprite('kill', 'SawbladeThings/attackv6', (defaultBoyfriendX)-3650, (defaultBoyfriendY)+450)
	addAnimationByPrefix('kill', 'fire', 'kb_attack_animation_fire', 24, false)
    scaleObject('kill', 1.18, 1.18)
	addLuaSprite('kill', true)
	setProperty('kill.alpha', 0)

    --PREPARE ANIMATION

	makeAnimatedLuaSprite('SawBlade1', 'SawbladeThings/attackv6Prepare', (defaultBoyfriendX)-1660, (defaultBoyfriendY)+485)
    addAnimationByPrefix('SawBlade1', 'Preparing', 'kb_attack_animation_prepare', 20, false)
	scaleObject('SawBlade1', 1.18, 1.18)
    addLuaSprite('SawBlade1', true)
    setProperty('SawBlade1.alpha', 0)

	--HITS SHITS

	makeAnimatedLuaSprite('Lifehit', 'SawbladeThings/hit', 610, 79)
    addAnimationByPrefix('Lifehit', 'low', 'Hit-Low', 20, false)
	addAnimationByPrefix('Lifehit', 'quad', 'Hit-quarter', 20, false)
	addAnimationByPrefix('Lifehit', 'half', 'Hit-half', 20, false)
	setObjectOrder('Lifehit', getObjectOrder('iconP1') - 1)
	setObjectCamera('Lifehit', 'camHUD')
	scaleObject('Lifehit', 0.5, 0.5)
    addLuaSprite('Lifehit', true)
    setProperty('Lifehit.alpha', 0)
	if not downscroll then
		setProperty('Lifehit.y', 640)
	end

	--SINGLE ALERT

	makeAnimatedLuaSprite('warning', 'Alerts/attack_alert_Hell', 475, 180)
	addAnimationByPrefix('warning', 'alert', 'kb_attack_animation_alert-single', 24, false)
	scaleObject('warning', 1.4, 1.4)
	updateHitbox('warning')
	setObjectCamera('warning', 'camHUD')
	addLuaSprite('warning', true)
	setProperty('warning.alpha', 0)

    --DUO ALERT

    makeAnimatedLuaSprite('warn', 'Alerts/attack_alert_Hell', 375, 100)
    addAnimationByPrefix('warn', 'alertdouble', 'kb_attack_animation_alert-double', 24, false)
	scaleObject('warn', 1.4, 1.4)
	updateHitbox('warn')
	setObjectCamera('warn', 'other')
	addLuaSprite('warn', true)
	setProperty('warn.alpha', 0)
	setProperty('warn.x', 370)
	setProperty('warn.y', 160)

    --TRIPLE ALERT

    makeAnimatedLuaSprite('alerting', 'Alerts/attack_alert_Hell', 375, 100)
	addAnimationByPrefix('alerting', 'alerttriple', 'kb_attack_animation_alert-triple', 24, false)
	scaleObject('alerting', 1.4, 1.4)
	updateHitbox('alerting')
	setObjectCamera('alerting', 'camHUD')
	addLuaSprite('alerting', true)
	setProperty('alerting.alpha', 0)
	setProperty('alerting.x', 320)
	setProperty('alerting.y', 120)

    --QUADRUPLE ALERT

	makeAnimatedLuaSprite('warned', 'Alerts/attack_alert_Hell', 375, 100)
	addAnimationByPrefix('warned', 'alertquad', 'kb_attack_animation_alert-quad', 24, false)
	scaleObject('warned', 1.4, 1.4)
	updateHitbox('warned')
	setObjectCamera('warned', 'hud')
	addLuaSprite('warned', true)
	setProperty('warned.alpha', 0)
	setProperty('warned.x', 320)
	setProperty('warned.y', 130)

end

function dodge()
    dodging = true
    canDodge = false

	characterPlayAnim('bf', 'dodge', true)
    setProperty('bf.specialAnim', true)
    playSound('dodge01')

    runTimer('dodge', dodgeTiming)
	runTimer('dodging', 0.25)
end

function onUpdate(elapsed)

	--HITS SYSTEM VISUALS

	if beHit then
		if hits == 1 then
			limitHits = 3
			setProperty('Lifehit.alpha', 1)
			setObjectOrder('Lifehit', getObjectOrder('iconP1') - 1)
			objectPlayAnimation('Lifehit', 'low', false);
		elseif hits == 2 then
			limitHits = 2
			objectPlayAnimation('Lifehit', 'quad', false);
			setObjectOrder('Lifehit', getObjectOrder('iconP1') - 1)
			setProperty('Lifehit.alpha', 1)
		elseif hits == 3 then
			limitHits = 1
			objectPlayAnimation('Lifehit', 'half', false);
			setObjectOrder('Lifehit', getObjectOrder('iconP1') - 1)
			setProperty('Lifehit.alpha', 1)
		end
	end

	--BF SHITS

	if getProperty('health') <= .71 and hits == 1 then
		setProperty('iconP1.animation.curAnim.curFrame', 1)
	else
		setProperty('iconP1.animation.curAnim.curFrame', 0)
	end

	if getProperty('health') <= .63 and limitHits == 3 then
		setProperty('health', -1)
	end

	if getProperty('health') <= .90 and hits == 2 then
		setProperty('iconP1.animation.curAnim.curFrame', 1)
	else
		setProperty('iconP1.animation.curAnim.curFrame', 0)
	end

	if getProperty('health') <= .78 and limitHits == 2 then
		setProperty('health', -1)
	end

	if getProperty('health') <= 1.15 and hits == 3 then
		setProperty('iconP1.animation.curAnim.curFrame', 1)
	else
		setProperty('iconP1.animation.curAnim.curFrame', 0)
	end

	if getProperty('health') <= 1.1 and limitHits == 1 then
		setProperty('health', -1)
	end

	--DODGE MECHANIC FUNCTION

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not dodging and canDodge and not botPlay then
        dodge()
    end
end

function onTimerCompleted(tag)
	if tag == 'dodge' then
		characterDance('bf')

		runTimer('dodgeCooldown', dodgeCooldown)
	elseif tag == 'dodging' then
        dodging = false
	elseif tag == 'dodgeCooldown' then
        canDodge = true
    elseif tag == 'checkDodging' then
        if canDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			if beHit then
				hits = hits+1
				setProperty('Lifehit.alpha', 1)
			end
            if instakill then
                setProperty('health', -1)
            end
			if hits > maxHits then
				setProperty('health', -1)
			end
        end
	elseif tag == 'checkDodging2' then
        if canDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			if beHit then
				hits = hits+1
				setProperty('Lifehit.alpha', 1)
			end
            if instakill then
                setProperty('health', -1)
            end
			if hits > maxHits then
				setProperty('health', -1)
			end
        end
	elseif tag == 'checkDodging3' then
        if canDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			if beHit then
				hits = hits+1
				setProperty('Lifehit.alpha', 1)
			end
            if instakill then
                setProperty('health', -1)
            end
			if hits > maxHits then
				setProperty('health', -1)
			end
        end
	elseif tag == 'checkDodging4' then
        if canDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			if beHit then
				hits = hits+1
				setProperty('Lifehit.alpha', 1)
			end
            if instakill then
                setProperty('health', -1)
            end
			if hits > maxHits then
				setProperty('health', -1)
			end
        end
    end
end

doWarning = function()
	playSound('alert', 1)
	setProperty('warning.alpha', 1)
	objectPlayAnimation('warning', 'alert', true);
	setProperty('kill.alpha', 1)
end
doWarningDuo = function()
	playSound('alertDouble', 1)
	setProperty('warn.alpha', 1)
	objectPlayAnimation('warn', 'alertdouble', true);
	setProperty('kill.alpha', 1)
end

doWarningTriple = function()
	playSound('alertTriple', 1)	
	setProperty('alerting.alpha', 1)
	objectPlayAnimation('alerting', 'alerttriple', true);
end

doWarningQuadruple = function()
	playSound('alertQuadruple', 1)	
	setProperty('warned.alpha', 1)
	objectPlayAnimation('warned', 'alertquad', true);
end

doAttack = function()
    playSound('attack', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('checkDodging', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'dodge', true)
		setProperty('bf.specialAnim', true)
		playSound('dodge01')
	end
end

doAttackDuo = function()
    playSound('attack-double', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('checkDodging2', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'dodge', true)
		setProperty('bf.specialAnim', true)
		playSound('dodge01')
	end
end

doAttackTriple = function()
    playSound('attack-triple', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('checkDodging', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'dodge', true)
		setProperty('bf.specialAnim', true)
		playSound('dodge01')
	end
end

doAttackQuadruple = function()
    playSound('attack-quadruple', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('checkDodging3', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'dodge', true)
		setProperty('bf.specialAnim', true)
		playSound('dodge01')
	end
end

function onBeatHit()

    --SINGLE MECHANIC

	if Sbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Sbeat1 == curBeat then
		doWarning()
	end
	if Sbeat2 == curBeat then
	    doAttack()
		setProperty('SawBlade1.alpha', 0)
	end

    --DUO MECHANIC

    if Dbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Dbeat1 == curBeat then
		doWarningDuo()
	end
	if Dbeat2 == curBeat then
	    doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if Dbeat3 == curBeat then
	    doAttackDuo()
	end

    --TRIPLE MECHANIC

    if Tbeat0 == curBeat then
		doWarningDuo()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Tbeat1 == curBeat then
		doWarningDuo()
	end
	if Tbeat2 == curBeat then
		doWarningTriple()
	end
    if Tbeat3 == curBeat then
		doWarningTriple()
    end
	if Tbeat4 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if Tbeat5 == curBeat then
		doAttackDuo()
	end
	if Tbeat6 == curBeat then
		doAttackTriple()
	end

    --TRIPLE FAST VARIANT

    if TFbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
    if TFbeat1 == curBeat then
		doWarningTriple()
    end
	if TFbeat2 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if TFbeat3 == curBeat then
		doAttackDuo()
	end
	if TFbeat4 == curBeat then
		doAttackTriple()
	end

    --QUADRUPLE MECHANIC

    if Qbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Qbeat1 == curBeat then
		doWarningDuo()
	end
	if Qbeat2 == curBeat then
		doWarningTriple()
	end
    if Qbeat3 == curBeat then
		doWarningQuadruple()
    end
	if Qbeat4 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if Qbeat5 == curBeat then
		doAttackDuo()
	end
	if Qbeat6 == curBeat then
		doAttackTriple()
	end
    if Qbeat7 == curBeat then
		doAttackQuadruple()
	end

    --QUADRUPLE FAST VARIANT

    if QFbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
    if QFbeat1 == curBeat then
		doWarningQuadruple()
    end
	if QFbeat2 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if QFbeat3 == curBeat then
		doAttackDuo()
	end
	if QFbeat4 == curBeat then
		doAttackTriple()
	end
    if QFbeat5 == curBeat then
		doAttackQuadruple()
	end
end
