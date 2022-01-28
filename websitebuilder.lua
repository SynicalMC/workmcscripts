local mon = peripheral.wrap("top")
local tools = peripheral.wrap("right")
local paint = peripheral.wrap("left")

mon.clear()
tools.clear()
paint.clear()

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

while true do
    local event,side,x,y = os.pullEvent("monitor_touch")
    if side == "top" then
        mon.setCursorPos(x,y)
        mon.blit(" ","f",color)
    end
    if side == "right" then
        
    end
    if side == "left" then
        if y == 1 then
            local base = x-1
            color = string.format("%x",base*255)
            color = color:sub(1,1)
            paint.setCursorPos(1,2)
            local msg = ""
            local tc = ""
            local bg = ""
            for i=1,monX do
                msg = msg.." "
                bg = bg.."0"
                tc = tc.."f"
            end
            paint.blit(msg,tc,bg)
            paint.setCursorPos(x,y+1)
            paint.blit(" ","f","7")
        end
    end
end
