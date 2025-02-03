mscroll = false

function onCreate()
    if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
		mscroll = true;
	elseif getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		mscroll = false;
	end
end

function onCreatePost()
    makeAnimatedLuaSprite("Sign1", "mechanics/Separate Signs Because/Sign1", 0, 0)
    addAnimationByPrefix("Sign1", "Active", "Signature Stop Sign 1", 24, false)
    addAnimationByPrefix("Sign1", "Inactive", "Signature Stop Sign Dissapear", 24, false)
    setObjectCamera("Sign1", "camOther")
    objectPlayAnimation("Sign1", "Inactive", true)
    scaleObject("Sign1", 0.8, 0.8)
    addLuaSprite("Sign1")

    makeAnimatedLuaSprite("Sign2", "mechanics/Separate Signs Because/Sign2", 0, 0)
    addAnimationByPrefix("Sign2", "Active", "Signature Stop Sign 2", 24, false)
    addAnimationByPrefix("Sign2", "Inactive", "Signature Stop Sign Dissapear", 24, false)
    setObjectCamera("Sign2", "camOther")
    objectPlayAnimation("Sign2", "Inactive", true)
    scaleObject("Sign2", 0.8, 0.8)
    addLuaSprite("Sign2")

    makeAnimatedLuaSprite("Sign3", "mechanics/Separate Signs Because/Sign3", 0, 0)
    addAnimationByPrefix("Sign3", "Active", "Signature Stop Sign 3", 24, false)
    addAnimationByPrefix("Sign3", "Inactive", "Signature Stop Sign Dissapear", 24, false)
    setObjectCamera("Sign3", "camOther")
    objectPlayAnimation("Sign3", "Inactive", true)
    scaleObject("Sign3", 0.8, 0.8)
    addLuaSprite("Sign3")

    makeAnimatedLuaSprite("Sign4", "mechanics/Separate Signs Because/Sign4", 0, 0)
    addAnimationByPrefix("Sign4", "Active", "Signature Stop Sign 4", 24, false)
    addAnimationByPrefix("Sign4", "Inactive", "Signature Stop Sign Dissapear", 24, false)
    setObjectCamera("Sign4", "camOther")
    objectPlayAnimation("Sign4", "Inactive", true)
    scaleObject("Sign4", 0.8, 0.8)
    addLuaSprite("Sign4")

    --Middle Scroll Code
    if mscroll == true then
        setProperty("Sign1.x", 500)
        setProperty("Sign1.y", 300)
        setProperty("Sign1.angle", 0)
        setProperty("Sign2.x", 500)
        setProperty("Sign2.y", 300)
        setProperty("Sign2.angle", 0)
        setProperty("Sign3.x", 500)
        setProperty("Sign3.y", 300)
        setProperty("Sign3.angle", 0)
        setProperty("Sign4.x", -200)
        setProperty("Sign4.y", 200)
        setProperty("Sign4.angle", 0)
    else
        setProperty("Sign1.x", 1000)
        setProperty("Sign1.y", 300)
        setProperty("Sign1.angle", -90)
        setProperty("Sign2.x", 1000)
        setProperty("Sign2.y", 300)
        setProperty("Sign2.angle", -90)
        setProperty("Sign3.x", 1000)
        setProperty("Sign3.y", -100)
        setProperty("Sign3.angle", -90)
        setProperty("Sign4.x", 700)
        setProperty("Sign4.y", 700)
        setProperty("Sign4.angle", -90)
    end
end

function onEvent(name, v1, v2)
    if name == "Sign Post" then
        if v1 == "Sign1" then
            objectPlayAnimation("Sign1", "Active", true)
        elseif v1 == "Sign2" then
            objectPlayAnimation("Sign2", "Active", true)
        elseif v1 == "Sign3" then
            objectPlayAnimation("Sign3", "Active", true)
        elseif v1 == "Sign4" then
            objectPlayAnimation("Sign4", "Active", false)
        end
    end
end