local component = require("component")
local capacitor = component.ie_hv_capacitor
local generator = component.ie_diesel_generator
local sleepTime = 15

function getCapacitorLevel()
    return ((capacitor.getEnergyStored() / capacitor.getMaxEnergyStored()) * 100)
end

function main()
    local isGeneratorOn = false
    generator.enableComputerControl(true)
    while true do
        local currentPower = getCapacitorLevel()
        local generatorBalance = generator.getTankInfo().amount
        os.execute("clear")
        print("Current Power: " .. tostring(currentPower) .. "%")
        print("Current Tank Level: " .. tostring(generatorBalance) .. "mb")
        if(isGeneratorOn) then
            print("Generator Status: Online")
        else
            print("Generator Status: Offline")
        end
        if(currentPower < 40 and isGeneratorOn == false) then
            generator.setEnabled(true)
            isGeneratorOn = true
        elseif (currentPower > 90 and isGeneratorOn) then
            generator.setEnabled(false)
            isGeneratorOn = false
        end
        os.sleep(sleepTime)
    end
end

main()
