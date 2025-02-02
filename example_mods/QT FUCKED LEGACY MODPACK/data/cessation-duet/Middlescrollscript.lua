function onStepHit()
    if curStep == 1200 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
            noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
            noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
            noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
            noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
            noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
        end
    end
end