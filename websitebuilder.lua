local mon = peripheral.wrap("top")
local tools = peripheral.wrap("right")
local paint = peripheral.wrap("left")
 
mon.clear()
tools.clear()
paint.clear()

local function getColor()
    while true do
    local _,s,x,y = os.pullEvent("monitor_touch")
        if s == "left" then
            local base = x-1
            color = string.format("%x",base*255)
            color = color:sub(1,1)
            return color
        end
    end
end
 
tools.setCursorPos(1,1)
term.redirect(tools)
print("Paint")
print("Text")
print("Buttons")
term.redirect(term.native())
 
local monX,monY = paint.getSize()
term.redirect(paint)
    paintutils.drawFilledBox(1,1,monX,monY,colors.white)
term.redirect(term.native())
 
paint.setCursorPos(1,1)
local color
for i=0,15 do
    color = string.format("%x", i*255)
    color = color:sub(1,1)
    paint.blit(" ","f",tostring(color))
end
 
 
local tool = ""
while true do
    local event,side,x,y = os.pullEvent("monitor_touch")
    if side == "top" then
        if tool == "paint" then
            mon.setCursorPos(x,y)
            mon.blit(" ","f",color)
        elseif tool == "text" then
            mon.setCursorPos(x,y)
            term.clear()
            term.setCursorPos(1,1)
            term.write("Text: ")
            local text = read()
            term.write("Select a color")
            local col = getColor()
            print()
            term.write("Select background ")
            local bgcol = getColor()
            _,s = os.pullEvent("monitor_touch")
            
            print(col)
            print(bgcol)
            
            bgcol = bgcol:sub(1,1)
            col = col:sub(1,1)
            
            local tcolor = ""
            local bgcolor = ""
            for i=1,text:len() do
                tcolor = color..col
                bgcolor = bgcolor..bgcol
            end
            mon.blit(text,tcolor,bgcolor)
        elseif tool == "buttons" then
        
        end
    end
    if side == "right" then
        if y == 1 and x <= 5 then
            tools.setCursorPos(1,2)
            tools.write("Text")
            tools.setCursorPos(1,3)
            tools.write("Buttons")
        
            tools.setCursorPos(1,1)
            tools.blit("Paint","11111","fffff")
            tool = "paint"
        elseif y == 2 and x <= 4 then
            tools.setCursorPos(1,1)
            tools.write("Paint")
            tools.setCursorPos(1,3)
            tools.write("Buttons")
            
            tools.setCursorPos(1,2)
            tools.blit("Text","1111","ffff")
            tool = "text"
        elseif y == 3 and x <= 7 then
            tools.setCursorPos(1,1)
            tools.write("Paint")
            tools.setCursorPos(1,2)
            tools.write("Text")
            
            tools.setCursorPos(1,3)
            tools.blit("Buttons","1111111","fffffff")
            tool = "buttons"
        end
    end
    if side == "left" then
        if y == 1 and x <= 16 then
            paint.setCursorPos(1,2)
            local msg = ""
            local tc = ""
            local bg = ""
            for i=1,monX do
                msg = msg.." "
                tc = tc.."0"
                bg = bg.."f"
            end
            paint.blit(msg,tc,bg)
            paint.setCursorPos(x,y+1)
            paint.blit(" ","f","7")
        end
    end
end
