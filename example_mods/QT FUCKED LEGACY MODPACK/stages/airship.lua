
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 2000;
local yy = 1050;
local xx2 = 2300;
local yy2 = 1050;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()

	makeLuaSprite('cargo walls', 'airship/cargowall', 250, 50);
	scaleLuaSprite('cargo walls', 1., 1.)
	addLuaSprite('cargo walls', false);

	makeLuaSprite('cargo', 'airship/cargo', 50, 50);
	scaleLuaSprite('cargo', 1., 1.)
	addLuaSprite('cargo', false);

    makeAnimatedLuaSprite('defeat','defeat',1100,300)
    scaleLuaSprite('defeat', 1., 1.)
    addAnimationByPrefix('defeat','haha defeat reference funny','defeat',24,true)
    addLuaSprite('defeat',false)
    setProperty('defeat.alpha',0)
end

