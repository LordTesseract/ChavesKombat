Options = Classe:extend()

function Options:New()

    print     = love.graphics.print
    rect      = love.graphics.rectangle
    draw      = love.graphics.draw
    key       = love.keyboard.down

    
    -- bgmVolume = 1
    -- voiceVOlume = 1
    -- soundVolume = 1
    options_option_values = {1,1,1}
    
    options_set = {350, 400, 450, 500}
    options_option = 1 -- Start Option
    max_options_option = 4

end

function Options:update(dt)

    
    if menu_option < 1 then
        menu_option = max_options
    end

    if menu_option > max_options then
        menu_option = 1
    end

    if options_option == 1 and love.keyboard.isDown("right") then 
        options_option_values[1] = options_option_values[1] + 0.1 * dt  
    elseif options_option == 1 and love.keyboard.isDown("right") then
        options_option_values[1] = options_option_values[1] - 0.1 * dt  
    end

    if options_option == 3 and love.keyboard.isDown("right") then 
        options_option_values[2] = options_option_values[2] + 0.1 * dt  
    elseif options_option == 1 and love.keyboard.isDown("right") then
        options_option_values[2] = options_option_values[2] - 0.1 * dt  
    end

    if options_option == 3 and love.keyboard.isDown("right") then 
        options_option_values[3] = options_option_values[3] + 0.1 * dt  
    elseif options_option == 1 and love.keyboard.isDown("right") then
        options_option_values[3] = options_option_values[3] - 0.1 * dt  
    end

    if options_option == max_options and love.keyboard.isDown("return") then actual_screen = "Menu" end

    menuBGM:setVolume(options_option_values[1])

end

function Options:draw()

    love.graphics.setFont(fonte)
    draw(MK_Screen, mkCenter, 50)

    print("BGM", mkCenter+50, 350)
    rect("fill", mkCenter+150, 350, 40, options_option_values[1] * 100)
    
    print("Vozes", mkCenter+50, 400)
    rect("fill", mkCenter+150, 400, 40, options_option_values[2] * 100)
    
    print("Sons", mkCenter+50, 450)
    rect("fill", mkCenter+150, 450, 40, options_option_values[3] * 100)
    
    print("Voltar", mkCenter+50, 500)
    
    draw(bola, mkCenter+10, 350, 0, 0.7, 0.7 )

end

function Options:getOptionsOption()
    
    return options_option
end

    
function Options:setOptionsOpt(opt)

    options_option = opt

end

