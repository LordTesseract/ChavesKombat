
function love.load()

    Classe = require("classic")
    require("Game")
    require("DevLogo") 
    require("Player") 
    require("Credits")
    require("Options")
    require("sAnimacao")

    
    game = Game()
    
    
end

function love.update(dt)
    game:update(dt)
end

function love.draw(dt)
    game:draw(dt)
end

function love.keypressed(k)
    
    
    if actual_screen == "Menu" then
	    if k == 'w' or k == 'up' then
            game:setMenuOpt(game:getMenuOpt() - 1)
        elseif k == 's' or k == 'down' then
            game:setMenuOpt(game:getMenuOpt() + 1)
        elseif k == 'space' or k == 'return' then
            game:selectOpt(menu_option)
        end
    end 

    if actual_screen == "Options" then
	    if k == 'w' or k == 'up' then
            game:setOptionOpt(game:getOptionOpt() - 1)
        elseif k == 's' or k == 'down' then
            game:setOptionOpt(game:getOptionOpt() + 1)
        end

        
    end 

    if actual_screen == "SelecionarPersonagem" then
        
        if k == 'j' and not game:getAnimate(1) then
            p1Select = p1Select - 1
        elseif k == 'l' and not game:getAnimate(1) then
            p1Select = p1Select + 1
        elseif k == "kp4" and not game:getAnimate(2) then
            p2Select = p2Select - 1
        elseif k == "kp6" and not game:getAnimate(2) then
            p2Select = p2Select + 1
        end


        if k == "a" or k == "s" or k == "d" or k == "f" then
            game:animateChar(1)
        end

        if k == "pageup" or k == "pagedown" or k == "insert" or k == "home" then
            game:animateChar(2)
        end
        
    end 
    

    if k == 'escape' then
        actual_screen = "Menu"
    end

    
    
    if k == 'r' then
		  love.load()
    end
end