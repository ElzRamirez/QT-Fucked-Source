beatanims = {'singLEFT-together', 'singDOWN-together', 'singUP-together', 'singRIGHT-together'}
function goodNoteHit(id,nd,nt,issus)
if nt == 'Beatbox Note' then
playAnim("bf", beatanims[nd + 1], true)
setProperty('bf.holdTimer', 0)
end
end
function opponentNoteHit(id,nd,nt,issus)
if nt == 'Beatbox Note' then
playAnim("bf", beatanims[nd + 1], true)
setProperty('bf.holdTimer', 0)
end
end