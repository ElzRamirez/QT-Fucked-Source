--Este script intercambia las flechas del jugador con las del oponente al inicio de la canción.

--Tabla para almacenar temporalmente las posiciones de las flechas
local tempPositions = {}

function onCountdownStarted()
    swapArrowPositions()
end

function swapArrowPositions()
    --Almacenar las posiciones de las flechas del oponente temporalmente
    for i = 0, 3 do
        tempPositions[i] = getPropertyFromGroup('opponentStrums', i, 'x')
    end

    --Intercambiar posiciones
    for i = 0, 3 do
        --Poner las posiciones del jugador en las del oponente
        setPropertyFromGroup('opponentStrums', i, 'x', getPropertyFromGroup('playerStrums', i, 'x'))
        --Poner las posiciones del oponente en las del jugador
        setPropertyFromGroup('playerStrums', i, 'x', tempPositions[i])
    end
end