local reactor = peripheral.wrap("back")
local monitor = peripheral.find("monitor")

print(reactor.getStatus())

while(true) do
  local act = reactor.getStatus()
  local dam = reactor.getDamagePercent()
  local cool = reactor.getHeatedCoolantFilledPercentage()
  local waste = reactor.getWasteFilledPercentage()
  
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write("Damage: "..dam)
  monitor.setCursorPos(1,2)
  monitor.write("Coolant: "..cool)
  monitor.setCursorPos(1,3)
  monitor.write("Waste: "..waste)
  monitor.setCursorPos(1,4)
  
  if(act and dam > 5) then
    print("Stopped because of damage")
    reactor.scram()
  
  
  elseif(act and cool > 15) then
    print("Stopped because of coolant")
    reactor.scram()
  
  
  elseif(act and waste > 15) then
    print("Stopped because of waste")
    reactor.scram()
  
  elseif(not act) then
     reactor.activate()
  end
  
  sleep(1)
end
