isHolding = false
healthDrained = 1
timeItTakes = 1.5


function onCreatePost()
    makeLuaSprite('healthTweenDummy','icons/icon-bf',0,0)
    setProperty('healthTweenDummy.visible', false)
    addLuaSprite('healthTweenDummy',true)    

    makeAnimatedLuaSprite("HPGremlin", "mechanics/HPGremlin", 900, 0)
    setObjectOrder("HPGremlin", getObjectOrder("iconP2"))
    setObjectCamera("HPGremlin", "camHud")
    addAnimationByPrefix("HPGremlin", "dissapear", "HP Gremlin Nope", 24, false)
    addAnimationByPrefix("HPGremlin", "spawn", "HP Gremlin Intro", 24, false)
    addAnimationByPrefix("HPGremlin", "idle", "HP Gremlin Idle", 24, true)
    addAnimationByPrefix("HPGremlin", "nyoom", "HP Gremlin Nyoom", 24, false)
    addAnimationByPrefix("HPGremlin", "grab", "HP Gremlin Grab", 24, true)
    addAnimationByPrefix("HPGremlin", "adios", "HP Gremlin Bye", 24, false)
    objectPlayAnimation("HPGremlin", "dissapear", false)
    addLuaSprite("HPGremlin")

    setProperty("HPGremlin.y", getProperty("healthBar.y") - 220)
end

--Made By Sit TopHat
function healthTween(var,time,ease)
    setProperty('healthTweenDummy.x', getProperty('health'))
    doTweenX('healthTween', 'healthTweenDummy', var, time, ease)
    doHealthTween=true
end

function onTimerCompleted(tag)
    if tag == "IntroTimer" then
        objectPlayAnimation("HPGremlin", "idle", false)
        runTimer("nyoomTimer", 0.6)
        setProperty("HPGremlin.y", getProperty("healthBar.y") - 220)
        setProperty("HPGremlin.x", 900)
    end
    if tag == "nyoomTimer" then
        objectPlayAnimation("HPGremlin", "nyoom", false)
        doTweenX('HPGremlinTweenGrab', 'HPGremlin', (getProperty("iconP2.x") + 50), 0.2, "expoInOut")
        runTimer("grabTimer", 0.2)
    end
    if tag == "grabTimer" then
        isHolding = true
        objectPlayAnimation("HPGremlin", "grab", false)
        healthTween(healthDrained, timeItTakes, expoInOut)
    end
    if tag == "reposition" then
        setProperty("HPGremlin.x", 900)
    end
end
        

function onTweenCompleted(tag)
    if tag=='healthTween' then
        doHealthTween=false 
        isHolding = false
        runTimer("reposition", 0.2)
        objectPlayAnimation("HPGremlin", "adios", false)
    end
end

function onUpdatePost() 
    if isHolding == true then
        setProperty("HPGremlin.x", getProperty("iconP2.x") + 120)
    end
    if doHealthTween then 
        setProperty('health', getProperty('healthTweenDummy.x')) 
    end
end

function onEvent(tag, v1, v2)
    if tag == "HP Gremlin" then
        healthDrained = v1
        timeItTakes = v2
        playSound('GremlinWoosh')
        objectPlayAnimation("HPGremlin", "spawn", false)
        runTimer("IntroTimer", 0.46)
        setProperty("HPGremlin.y", getProperty("healthBar.y") - 320)
        setProperty("HPGremlin.x", 800)
    end
end