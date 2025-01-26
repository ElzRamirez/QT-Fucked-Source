-- modchart por Slushi & Drkfon
function onCreatePost()
	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes',i,'y',-330)
    end
end

function onStepHit()
    if curStep == 1 then
        noteTweenAlpha("opo1", 0, 0, 0.1, "Linear")
        noteTweenAlpha("opo2", 1, 0, 0.1, "Linear")
        noteTweenAlpha("opo3", 2, 0, 0.1, "Linear")
        noteTweenAlpha("opo4", 3, 0, 0.1, "Linear")
    end
    if curStep == 64 then
        for i = 0,3 do
            if downscroll then
                setPropertyFromGroup('strumLineNotes',i,'y',570)
            else
                setPropertyFromGroup('strumLineNotes',i,'y',50)
            end
        end
    end
    if curStep == 800 then
        noteTweenAlpha("opo1", 0, 0.225, 3.2, "Linear")
        noteTweenAlpha("opo2", 1, 0.225, 3.2, "Linear")
        noteTweenAlpha("opo3", 2, 0.225, 3.2, "Linear")
        noteTweenAlpha("opo4", 3, 0.225, 3.2, "Linear")
    end
    if curStep == 1216 then
        noteTweenAlpha("opo1", 0, 0, 1.6, "Linear")
        noteTweenAlpha("opo2", 1, 0, 1.6, "Linear")
        noteTweenAlpha("opo3", 2, 0, 1.6, "Linear")
        noteTweenAlpha("opo4", 3, 0, 1.6, "Linear")
    end
    if curStep == 1328 then
        noteTweenAlpha("opo1", 0, 0.225, 1.6, "Linear")
        noteTweenAlpha("opo2", 1, 0.225, 1.6, "Linear")
        noteTweenAlpha("opo3", 2, 0.225, 1.6, "Linear")
        noteTweenAlpha("opo4", 3, 0.225, 1.6, "Linear")
    end
    if curStep == 1600 then
        noteTweenAlpha("opo1", 0, 0, 3.2, "Linear")
        noteTweenAlpha("opo2", 1, 0, 3.2, "Linear")
        noteTweenAlpha("opo3", 2, 0, 3.2, "Linear")
        noteTweenAlpha("opo4", 3, 0, 3.2, "Linear")
    end
end