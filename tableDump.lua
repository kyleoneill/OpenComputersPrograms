function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

 local people = {
    {
       name = "Fred",
       address = "16 Long Street",
       phone = "123456"
    },
 
    {
       name = "Wilma",
       address = "16 Long Street",
       phone = "123456"
    },
 
    {
       name = "Barney",
       address = "17 Long Street",
       phone = "123457"
    }
 
 }
 
 print("People:", dump(people))