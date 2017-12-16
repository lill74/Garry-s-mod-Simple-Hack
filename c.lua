Config = {}
Config.Aimbot = false
Config.ESP = false


surface.CreateFont( "f", {
	font = "Arial",
	size = 16,
} )

espname = ""

function menu()
frame = vgui.Create( "DFrame" )
frame:SetTitle("SET")
frame:SetSize( 300, 250 )
frame:Center()
frame:MakePopup()
frame.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 3,169,244) )
end

AddTab("ESP",1,1, function()
if(Config.ESP) then
		Config.ESP = false
	else
		Config.ESP = true
	end
gdg()
end)
AddTab("Anti Screen Grab",6,1, function()
antigrab()
end)
AddTab("User List",1,2, function()
userlist()
end)
AddTab("Fixed ESP",6,2, function()

asfas()
end)
AddTab("Aimbot",1,3, function()
	if(Config.Aimbot) then
		Config.Aimbot = false
	else
		Config.Aimbot = true
	end
fasd()
end)

local text = vgui.Create("RichText", frame);
text:SetSize(125,30);
text:SetPos(150,150);
text:SetText("Garry's mod Simple Hack (GSH)");


end

function AddTab(title,id,line,func)
local DermaButton = vgui.Create( "DButton", frame )
DermaButton:SetText( title )
DermaButton:SetPos( 25*id, 50 * line )
DermaButton:SetSize( 125, 30 )
DermaButton.DoClick = func or function() end
DermaButton.Paint = function(self) 
		surface.SetDrawColor(255,255,255,255)
	end
	DermaButton:SetFontInternal( "NanumGothic" )
end

function gdg()
hook.Add( "HUDPaint", "f", function()
	if(Config.ESP) then
	for k,v in pairs(player.GetAll()) do
 if v ~= LocalPlayer() and v:Alive() then
     local eyepos = v:EyePos():ToScreen()
	 draw.SimpleText("[" .. v:GetUserGroup ().. "]" .. v:Nick() .. "|" .. v:Health(),"f",eyepos.x ,eyepos.y, Color(255,255,255))
	draw.RoundedBox(2,eyepos.x - 2,eyepos.y, 3, 3, Color(255,255,255))
	 end
end
end
end )
end

function asfas()
hook.Add( "HUDPaint", "f", function()
	for k,v in pairs(player.GetAll()) do
 if v ~= LocalPlayer() and v:Alive() then
 	if(v:Nick() == espname) then
     local eyepos = v:EyePos():ToScreen()
	 draw.SimpleText("[" .. v:GetUserGroup ().. "]" .. v:Nick() .. "|" .. v:Health(),"f",eyepos.x ,eyepos.y, Color(255,255,255))
	draw.RoundedBox(2,eyepos.x - 2,eyepos.y, 3, 3, Color(255,255,255))
end
	 end
end
end )
end

function adduser(name)
	espname = name
end

function userlist()
	print("Name | UserGroup | HP | Armor | Distance | Money")
	for k,v in pairs(player.GetAll()) do
		local distance = v:GetPos():Distance(LocalPlayer():GetPos())
		print(v:Nick() .. " | " .. v:GetUserGroup () .. " | " .. v:Health() .. " | " .. v:Armor() .. " | " .. math.floor(distance + 0.5) .. " | " .. DarkRP.formatMoney(v:getDarkRPVar("money")))
	end
end

function antigrab()
local antigrab = ("dudedude")
render.Capture = function()
return antigrab
end
end

hook.Add("Think", "d" , function()
if(input.IsKeyDown(KEY_TAB) and input.IsKeyDown(KEY_LCONTROL))then
		menu()
end

if(input.IsKeyDown(KEY_BREAK)) then
	RunConsoleCommand("kill")
end
fasd()
end)

function fasd()
	if not(Config.Aimbot) then return false end
	local ply = LocalPlayer() 
	local trace = util.GetPlayerTrace( ply ) 
	local traceRes = util.TraceLine( trace )
if traceRes.HitNonWorld then
		local target = traceRes.Entity
		if target:IsPlayer() then 
			local targethead = target:LookupBone("ValveBiped.Bip01_Head1")
			local targetheadpos,targetheadang = target:GetBonePosition(targethead)
			ply:SetEyeAngles((targetheadpos - ply:GetShootPos()):Angle()) 
		end
	end
end